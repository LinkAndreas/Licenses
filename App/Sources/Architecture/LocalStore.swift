//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation
import SwiftUI

final class Store: ObservableObject {
    static let shared: Store = .init()

    @Published var isProcessing: Bool = false
    @Published var isTargeted: Bool
    @Published var progress: Float?
    @Published var githubRequestStatus: GithubRequestStatus?
    @Published var listEntries: [ListEntry] = []
    @Published var selectedRepository: GithubRepository?
    @Published var repositories: [GithubRepository] {
        didSet {
            listEntries = repositories.map {
                ListEntry(
                    id: $0.id,
                    title: $0.name,
                    detail: $0.version,
                    isProcessing: $0.isProcessing
                )
            }
        }
    }

    private var cancellables: Set<AnyCancellable> = []

    init(
        isTargeted: Bool = false,
        githubRequestStatus: GithubRequestStatus? = nil,
        repositories: [GithubRepository] = [],
        progress: Float? = nil
    ) {
        self.isTargeted = isTargeted
        self.githubRequestStatus = githubRequestStatus
        self.repositories = repositories
        self.progress = progress
    }

    func searchManifests(at path: URL) {
        isProcessing = true
        repositories = []
        selectedRepository = nil

        ManifestCollector.search(at: path)
            .flatMap(maxPublishers: .max(1), ManifestDecoder.decode)
            .receive(on: RunLoop.main)
            .handleEvents(
                receiveCompletion: { _ in
                    self.isProcessing = false
                }
            )
            .sink(receiveValue: self.add(repository:))
            .store(in: &cancellables)
    }

    func fetchLicenses() {
        startProcessing()
        repositories
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
            .handleEvents(
                receiveOutput: { $0.isProcessing = false },
                receiveCompletion: { _ in self.isProcessing = false }
            )
            .sink(receiveValue: finishedProcessing)
            .store(in: &cancellables)
    }

    private func startProcessing() {
        isProcessing = true
        repositories = repositories.map { repository in
            guard repository.license == nil else { return repository }

            let modifiedRepository: GithubRepository = repository
            modifiedRepository.isProcessing = true
            return modifiedRepository
        }
    }

    func exportLicenses() {
        isProcessing = true
        isProcessing = false
    }

    func selectRepository(with id: UUID?) {
        guard let id = id else { return selectedRepository = nil }

        selectedRepository = repositories.first { $0.id == id }
    }
}

extension Store {
    private func add(repository: GithubRepository) {
        guard !repositories.contains(where: isConsideredEqual(repository)) else { return }

        repositories = (repositories + [repository]).sorted { $0.name.lowercased() < $1.name.lowercased() }
    }

    private func isConsideredEqual(_ lhs: GithubRepository) -> ((GithubRepository) -> Bool) {
        return { rhs in
            lhs.name == rhs.name && lhs.version == rhs.version && lhs.packageManager == rhs.packageManager
        }
    }

    private func finishedProcessing(repository: GithubRepository) {
        if selectedRepository?.id == repository.id {
            selectedRepository = repository
        }

        if let index = repositories.firstIndex(where: { $0.id == repository.id }) {
            repositories[index] = repository
        }
    }
}
