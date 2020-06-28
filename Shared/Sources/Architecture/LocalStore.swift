//
//  Store.swift
//  iOS
//
//  Created by Andreas Link on 27.06.20.
//

import Foundation
import Combine

final class LocalStore: ObservableObject {
    @Published var isTargeted: Bool
    @Published var repositories: [GithubRepository]
    @Published var selectedRepository: GithubRepository?
    @Published var progress: Float?
    var processingUUIDs: Set<UUID>
    private var cancellables: Set<AnyCancellable> = []

    init(
        isTargeted: Bool = false,
        repositories: [GithubRepository] = [],
        selectedRepository: GithubRepository? = nil,
        progress: Float? = nil,
        processingUUIDs: Set<UUID> = .init()
    ) {
        self.isTargeted = isTargeted
        self.repositories = repositories
        self.selectedRepository = selectedRepository
        self.progress = progress
        self.processingUUIDs = processingUUIDs
    }

    func searchManifests(at path: URL) {
        repositories = []
        ManifestCollector.search(at: path)
            .flatMap(ManifestDecoder.decode)
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .delay(for: 0.2, scheduler: RunLoop.main)
            .sink { [self] in add(repository: $0) }
            .store(in: &cancellables)
    }

    func fetchLicenses() {
        processingUUIDs = Set<UUID>(repositories.filter({ $0.license == nil }).map(\.id))
        let repositoryCount: Float = Float(repositories.count)
        repositories
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
            }
            .receive(on: RunLoop.main)
            .sink { [self] repository, progress in
                finishedProcessing(repository: repository, withProgress: progress)
            }
            .store(in: &cancellables)
    }
}

extension LocalStore {
    private func add(repository: GithubRepository) {
        guard !repositories.contains(where: isConsideredEqual(repository)) else { return }

        repositories = (repositories + [repository]).sorted { $0.name < $1.name }
    }

    private func isConsideredEqual(_ lhs: GithubRepository) -> ((GithubRepository) -> Bool) {
        return { rhs in
            lhs.name == rhs.name && lhs.version == rhs.version && lhs.packageManager == rhs.packageManager
        }
    }

    private func finishedProcessing(repository: GithubRepository, withProgress progress: Float) {
        processingUUIDs.remove(repository.id)
        if let index = repositories.firstIndex(where: { $0.id == repository.id }) {
            repositories[index] = repository
        }

        if progress == 1.0 {
            Just(())
                .delay(for: 0.5, scheduler: RunLoop.main)
                .sink { [self] _ in
                    self.progress = progress
                }
                .store(in: &cancellables)
        } else {
            self.progress = progress
        }
    }
}
