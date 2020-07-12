//
//  Store.swift
//  iOS
//
//  Created by Andreas Link on 27.06.20.
//

import Foundation
import Combine
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
            listEntries = ListEntryFactory.makeListEntries(from: repositories)
        }
    }

    private var cancellables: Set<AnyCancellable> = []
    private var remainingRepositories: Int = 0
    private var totalRepositories: Int = 0

    init(
        isTargeted: Bool = false,
        progress: Float? = nil,
        githubRequestStatus: GithubRequestStatus? = nil,
        repositories: [GithubRepository] = [],
        selectedRepository: GithubRepository? = nil
    ) {
        self.isTargeted = isTargeted
        self.progress = progress
        self.githubRequestStatus = githubRequestStatus
        self.repositories = repositories
        self.selectedRepository = selectedRepository
    }

    func searchManifests(at path: URL) {
        ManifestCollector.search(at: path)
            .flatMap(maxPublishers: .max(1), ManifestDecoder.decode)
            .receive(on: RunLoop.main)
            .handleEvents(
                receiveSubscription: self.startSearchingManifests,
                receiveCompletion: self.stoppedSearchingManifests
            )
            .sink(receiveValue: self.add(repository:))
            .store(in: &cancellables)

    }

    private func startSearchingManifests(subscription: Subscription) {
        self.isProcessing = true
        repositories = []
        selectedRepository = nil
    }

    private func stoppedSearchingManifests(completion: Subscribers.Completion<Never>) {
        self.isProcessing = false
    }

    func fetchLicenses() {
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
                receiveSubscription: self.startFetchingLicenses,
                receiveOutput: self.didProcessRepository,
                receiveCompletion: self.stopFetchingLicenses
            )
            .sink(receiveValue: finishedProcessing)
            .store(in: &cancellables)
    }

    private func startFetchingLicenses(subscription: Subscription) {
        isProcessing = true
        var totalRepositories: Int = 0
        repositories = repositories.map { repository in
            guard repository.license == nil else { return repository }

            totalRepositories += 1
            let modifiedRepository: GithubRepository = repository
            modifiedRepository.isProcessing = true
            return modifiedRepository
        }
        if totalRepositories > 0 {
            self.remainingRepositories = totalRepositories
            self.totalRepositories = totalRepositories
            computeProgress()
        }
    }

    private func didProcessRepository(for repository: GithubRepository) {
        repository.isProcessing = false
        remainingRepositories -= 1
        computeProgress()
    }

    private func stopFetchingLicenses(completion: Subscribers.Completion<Never>) {
        isProcessing = false
        progress = 1.0
        Just(())
            .delay(for: 1, scheduler: RunLoop.main)
            .sink { _ in self.progress = nil }
            .store(in: &cancellables)
    }

    private func computeProgress() {
        progress = Float(1.0) - Float(
            Double(remainingRepositories) / Double(totalRepositories)
        )
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
