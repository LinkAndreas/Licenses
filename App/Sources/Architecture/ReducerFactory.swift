//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum ReducerFactory {
    static var appReducer: Reducer<AppState, AppAction, AppEnvironment> = .init { state, action, environment in
        switch action {
        case let .searchManifests(path):
            state.repositories = []
            return .concatenate(
                ManifestCollector.search(at: path)
                    .flatMap(ManifestDecoder.decode)
                    .map(AppAction.addRepository)
                    .eraseToSideEffect(),
                .action(.fetchLicenses)
            )

        case let .addRepository(repository):
            guard !state.repositories.contains(
                where: {
                    $0.name == repository.name
                    && $0.version == repository.version
                    && $0.packageManager == repository.packageManager
                }
            ) else { return .none }

            state.repositories = (state.repositories + [repository]).sorted { $0.name < $1.name }
            return .none

        case .fetchLicenses:
            state.processingUUIDs = Set<UUID>(state.repositories.filter({ $0.license == nil }).map(\.id))
            let repositoryCount: Float = Float(state.repositories.count)
            return state
                .repositories
                .enumerated()
                .publisher
                .flatMap(maxPublishers: .max(1)) { index, repository in
                    Just(repository)
                        .flatMap { (repository: GithubRepository) -> AnyPublisher<(GithubRepository, Float), Never> in
                            CocoaPodsRepositoryProcessor.process(repository: repository)
                                .map { ($0, (Float(index + 1) / repositoryCount)) }
                                .eraseToAnyPublisher()
                        }
                        .flatMap { repository, progress in
                            LicenseProcessor.process(repository: repository)
                                .map { ($0, progress) }
                                .eraseToAnyPublisher()
                        }
                        .map(AppAction.finishedProcessingRepository)
                        .receive(on: RunLoop.main)
                        .eraseToSideEffect()
                        .cancellable(id: "fetchLicenses")
                }
                .eraseToSideEffect()

        case let .finishedProcessingRepository(repository, progress):
            state.processingUUIDs.remove(repository.id)
            if let index = state.repositories.firstIndex(where: { $0.id == repository.id }) {
                state.repositories[index] = repository
            }

            return progress == 1.0 ? .concatenate(
                .action(.setProgress(progress)),
                Just(AppAction.setProgress(nil)).delay(for: 1, scheduler: RunLoop.main).eraseToSideEffect()
            ) : .action(.setProgress(progress))

        case let .setProgress(progress):
            state.progress = progress
            return .none

        case let .selectRepository(repository):
            state.selectedRepository = repository
            return .none

        case let .changeIsTargeted(isTargeted):
            state.isTargeted = isTargeted
            return .none

        case let .updateGithubRequestStatus(status):
            state.githubRequestStatus = status
            return .none

        case let .startedProcessing(repository):
            state.processingUUIDs.insert(repository.id)
            return .none

        case let .stoppedProcessing(repository):
            state.processingUUIDs.remove(repository.id)
            return .none
        }
    }
}
