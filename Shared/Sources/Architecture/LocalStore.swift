//
//  Store.swift
//  iOS
//
//  Created by Andreas Link on 27.06.20.
//

import Foundation
import Combine
import SwiftUI

final class LocalStore: ObservableObject {
    static let shared: LocalStore = .init()

    @Published var isTargeted: Bool
    @Published var progress: Float?
    @Published var listEntries: [ListEntry] = []
    @Published var selectedRepository: GithubRepository?

    @Published var repositories: [GithubRepository] {
        didSet {
            listEntries = repositories.map { ListEntry(id: $0.id, title: $0.name, detail: $0.version) }
        }
    }
    private var cancellables: Set<AnyCancellable> = []

    init(
        isTargeted: Bool = false,
        repositories: [GithubRepository] = [],
        progress: Float? = nil
    ) {
        self.isTargeted = isTargeted
        self.repositories = repositories
        self.progress = progress
    }

    func searchManifests(at path: URL) {
        repositories = []
        selectedRepository = nil

        ManifestCollector.search(at: path)
            .flatMap(maxPublishers: .max(1), ManifestDecoder.decode)
            .receive(on: RunLoop.main)
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
            .handleEvents(receiveOutput: { $0.isProcessing = false })
            .sink(receiveValue: finishedProcessing)
            .store(in: &cancellables)
    }

    private func startProcessing() {
        repositories = repositories.map { repository in
            guard repository.license == nil else { return repository }

            let modifiedRepository: GithubRepository = repository
            modifiedRepository.isProcessing = true
            return modifiedRepository
        }
    }

    func exportLicenses() {

    }

    func selectRepository(with id: UUID?) {
        guard let id = id else { return selectedRepository = nil }

        selectedRepository = repositories.first { $0.id == id }
    }
}

extension LocalStore {
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
