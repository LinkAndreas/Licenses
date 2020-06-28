//
//  Store.swift
//  iOS
//
//  Created by Andreas Link on 27.06.20.
//

import Foundation
import Combine

final class WindowStore: ObservableObject {
    @Published var isTargeted: Bool
    @Published var repositories: [GithubRepository]
    var selectedRepository: GithubRepository?
    var githubRequestStatus: GithubRequestStatus?
    @Published var progress: Float?
    var processingUUIDs: Set<UUID>
    private var cancellables: Set<AnyCancellable> = []

    init(
        isTargeted: Bool = false,
        repositories: [GithubRepository] = [],
        selectedRepository: GithubRepository? = nil,
        githubRequestStatus: GithubRequestStatus? = nil,
        progress: Float? = nil,
        processingUUIDs: Set<UUID> = .init()
    ) {
        self.isTargeted = isTargeted
        self.repositories = repositories
        self.selectedRepository = selectedRepository
        self.githubRequestStatus = githubRequestStatus
        self.progress = progress
        self.processingUUIDs = processingUUIDs
    }

    func searchManifests(at path: URL) {
        repositories = []
        ManifestCollector.search(at: path)
            .flatMap(ManifestDecoder.decode)
            .eraseToAnyPublisher()
            .sink { [self] in add(repository: $0) }
            .store(in: &cancellables)
    }

    private func add(repository: GithubRepository) {
        guard !repositories.contains(where: isConsideredEqual(repository)) else { return }

        repositories = (repositories + [repository]).sorted { $0.name < $1.name }
    }

    private func isConsideredEqual(_ lhs: GithubRepository) -> ((GithubRepository) -> Bool) {
        return { rhs in
            lhs.name == rhs.name && lhs.version == rhs.version && lhs.packageManager == rhs.packageManager
        }
    }
}
