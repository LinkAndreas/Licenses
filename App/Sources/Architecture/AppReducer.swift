//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = { state, action, environment in
    switch action {
    case let .add(repository):
        let isConsideredEqual: (GithubRepository) -> ((GithubRepository) -> Bool) = { lhs in
            return { rhs in
                lhs.name == rhs.name && lhs.version == rhs.version && lhs.packageManager == rhs.packageManager
            }
        }

        guard !state.repositories.contains(where: isConsideredEqual(repository)) else { return nil }

        state.repositories = (state.repositories + [repository]).sorted { $0.name.lowercased() < $1.name.lowercased() }
        return nil

    case let .updateErrorMessage(message):
        state.errorMessage = message
        return nil

    case .startSearchingManifests:
        state.isProcessing = true
        state.repositories = []
        state.selectedRepository = nil
        return nil

    case .stopSearchingManifests:
        state.isProcessing = false
        return Just(AppAction.fetchLicenses)
            .eraseToAnyPublisher()

    case let .updateIsTargeted(isTargeted):
        state.isTargeted = isTargeted
        return nil

    case .resetProgress:
        state.progress = nil
        return nil

    case .updateProgress:
        state.progress = Float(1.0) - Float(Double(state.remainingRepositories) / Double(state.totalRepositories))
        return nil

    case .didStartFetchingLicenses:
        state.isProcessing = true
        var totalRepositories: Int = 0
        state.repositories = state.repositories.map { repository in
            guard repository.license == nil else { return repository }

            totalRepositories += 1
            let modifiedRepository: GithubRepository = repository
            modifiedRepository.isProcessing = true
            return modifiedRepository
        }

        if totalRepositories > 0 {
            state.remainingRepositories = totalRepositories
            state.totalRepositories = totalRepositories
            return Just(AppAction.updateProgress).eraseToAnyPublisher()
        }

        return nil

    case .didStopFetchingLicenses:
        state.isProcessing = false
        state.progress = 1.0
        return Just(.resetProgress)
            .delay(for: 1, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()

    case let .didProcess(repository):
        if state.selectedRepository?.id == repository.id {
            state.selectedRepository = repository
        }

        if let index = state.repositories.firstIndex(where: { $0.id == repository.id }) {
            state.repositories[index] = repository
            state.repositories[index].isProcessing = false
        }

        state.remainingRepositories -= 1
        return Just(AppAction.updateProgress).eraseToAnyPublisher()

    case .fetchLicenses:
        return state.repositories
            .filter { $0.license == nil }
            .publisher
            .flatMap(maxPublishers: .max(1)) { repository in
                Just(repository)
                    .flatMap { (repository: GithubRepository) -> AnyPublisher<GithubRepository, Never> in
                        CocoaPodsRepositoryProcessor.process(repository: repository)
                            .eraseToAnyPublisher()
                    }
                    .flatMap { repository in
                        LicenseProcessor.process(repository: repository)
                            .eraseToAnyPublisher()
                    }
            }
            .receive(on: RunLoop.main)
            .map(AppAction.didProcess(repository:))
            .prepend(AppAction.didStartFetchingLicenses)
            .append(AppAction.didStopFetchingLicenses)
            .eraseToAnyPublisher()

    case let .exportLicenses(destination):
        state.isProcessing = true

        let csvRows: [[String]] = CSVRowFactory.makeRows(from: state.repositories)
        CSVExporter.exportCSV(fromRows: csvRows, toDestination: destination)

        state.isProcessing = false
        return nil

    case let .handle(providers):
        return providers
            .publisher
            .flatMap { provider in
                Future<URL?, Never> { promise in
                    provider.loadDataRepresentation(
                        forTypeIdentifier: "public.file-url",
                        completionHandler: { data, _ in
                            guard
                                let data = data,
                                let path = NSString(data: data, encoding: 4),
                                let url = URL(string: path as String)
                            else {
                                return promise(.success(nil))
                            }

                            promise(.success(url))
                        }
                    )
                }
            }
            .collect()
            .receive(on: RunLoop.main)
            .map { urls in urls.compactMap { $0 } }
            .map(AppAction.searchManifests(filePaths:))
            .eraseToAnyPublisher()

    case let .selectedRepository(id):
        if let id = id {
            state.selectedRepository = state.repositories.first { $0.id == id }
        } else {
            state.selectedRepository = nil
        }

        return nil

    case let .searchManifests(filePaths):
        return ManifestPublisher(filePaths: filePaths)
            .flatMap(maxPublishers: .max(1), ManifestDecoder.decode)
            .receive(on: RunLoop.main)
            .map(AppAction.add(repository:))
            .prepend(AppAction.startSearchingManifests)
            .append(AppAction.stopSearchingManifests)
            .eraseToAnyPublisher()
    }
}
