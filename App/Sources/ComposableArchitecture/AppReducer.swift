//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import ComposableArchitecture
import Foundation

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .init { state, action, environment in
    switch action {
    case let .add(repository):
        let isConsideredEqual: (GithubRepository) -> ((GithubRepository) -> Bool) = { lhs in
            return { rhs in
                lhs.name == rhs.name && lhs.version == rhs.version && lhs.packageManager == rhs.packageManager
            }
        }

        guard !state.repositories.contains(where: isConsideredEqual(repository)) else { return .none }

        state.repositories = (state.repositories + [repository]).sorted { $0.name.lowercased() < $1.name.lowercased() }
        return .none

    case let .updateErrorMessage(message):
        state.errorMessage = message
        return .none

    case .startSearchingManifests:
        state.isProcessing = true
        state.repositories = []
        state.selectedRepository = nil
        return .none

    case .stopSearchingManifests:
        state.isProcessing = false
        return .none

    case let .updateIsTargeted(isTargeted):
        state.isTargeted = isTargeted
        return .none

    case .resetProgress:
        state.progress = nil
        return .none

    case .updateProgress:
        state.progress = Float(1.0) - Float(Double(state.remainingRepositories) / Double(state.totalRepositories))
        return .none

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
            return .init(value: .updateProgress)
        }

        return .none

    case .didStopFetchingLicenses:
        state.isProcessing = false
        state.progress = 1.0
        return Effect(value: .resetProgress)
            .delay(for: 1, scheduler: DispatchQueue.main)
            .eraseToEffect()

    case let .didProcess(repository):
        if state.selectedRepository?.id == repository.id {
            state.selectedRepository = repository
        }

        if let index = state.repositories.firstIndex(where: { $0.id == repository.id }) {
            state.repositories[index] = repository
            state.repositories[index].isProcessing = false
        }

        state.remainingRepositories -= 1
        return .init(value: .updateProgress)

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
            .eraseToEffect()

    case let .exportLicenses(destination):
        state.isProcessing = true

        let csvRows: [[String]] = CSVRowFactory.makeRows(from: state.repositories)
        CSVExporter.exportCSV(fromRows: csvRows, toDestination: destination)

        state.isProcessing = false
        return .none

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
            .eraseToAnyPublisher()
            .collect()
            .receive(on: RunLoop.main)
            .map { urls in urls.compactMap { $0 } }
            .map(AppAction.searchManifests(filePaths:))
            .eraseToEffect()

    case let .selectedRepository(id):
        if let id = id {
            state.selectedRepository = state.repositories.first { $0.id == id }
        } else {
            state.selectedRepository = nil
        }

        return .none

    case let .searchManifests(filePaths):
        return ManifestPublisher(filePaths: filePaths)
            .flatMap(maxPublishers: .max(1), ManifestDecoder.decode)
            .receive(on: RunLoop.main)
            .map(AppAction.add(repository:))
            .prepend(AppAction.startSearchingManifests)
            .append(AppAction.stopSearchingManifests)
            .eraseToEffect()
    }
}
