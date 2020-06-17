//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum ReducerFactory {
    static var appReducer: Reducer<AppState, AppAction, AppEnvironment> = .init { state, action, environment in
        switch action {
        case let .searchManifests(path):
            return ManifestCollector.search(at: path)
                .map(AppAction.processManifests)
                .receive(on: RunLoop.main)
                .eraseToSideEffect()

        case let .processManifests(manifests):
            var repositories: [GithubRepository] = ManifestDecoder.decode(manifests)
            repositories = [GithubRepository](Set<GithubRepository>(repositories))
            state.repositories = repositories
            return .action(.selectRepository(repositories.first))

        case let .updateRepository(repository):
            if let index = state.repositories.firstIndex(where: { $0.id == repository.id }) {
                state.repositories[index] = repository

                if state.selectedRepository?.id == repository.id {
                    state.selectedRepository = repository
                }
            }

            return .none

        case let .fetchRepositoryMetaDataIfNeeded(repository):
            guard let repository = repository, repository.license == nil else { return .none }

            return .concatenate(
                .action(.startedProcessing(repository)),
                Just(repository)
                .flatMap { (repository: GithubRepository) -> AnyPublisher<GithubRepository, Never> in
                    guard
                        repository.packageManager == .cocoaPods,
                        repository.url == nil
                    else { return Just(repository).eraseToAnyPublisher() }

                    return CocoaPodsRepositoryProcessor.process(repository: repository)
                }
                .flatMap(LicenseProcessor.process)
                .map(AppAction.updateRepository)
                .receive(on: RunLoop.main)
                .eraseToSideEffect()
                .cancellable(id: "fetchRepositoryMetaData"),
                .action(.stoppedProcessing(repository))
            )

        case let .selectRepository(repository):
            state.selectedRepository = repository

            return .action(.fetchRepositoryMetaDataIfNeeded(repository))

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
