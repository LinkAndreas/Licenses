//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

struct AppReducer: BlocReducer {
    private enum Constants {
        static let errorMessageSubscriptionID: String = "ErrorMessageSubscriptionID"
    }

    func reduce( // swiftlint:disable:this cyclomatic_complexity function_body_length
        state: inout AppState,
        action: AppAction,
        environment: AppEnvironment
    ) -> Effect<AppAction, Never> {
        switch action {
        case let .add(repository):
            let isConsideredEqual: (GithubRepository) -> ((GithubRepository) -> Bool) = { lhs in
                return { rhs in
                    lhs.name == rhs.name && lhs.version == rhs.version && lhs.packageManager == rhs.packageManager
                }
            }

            guard !state.repositories.contains(where: isConsideredEqual(repository)) else { return .none }

            state.repositories = (state.repositories + [repository]).sorted { lhsRepository, rhsRepository in
                lhsRepository.name.lowercased() < rhsRepository.name.lowercased()
            }

            return .none

        case let .updateErrorMessage(message):
            state.errorMessage = message
            return .none

        case .startSearchingManifests:
            state.isProcessing = true
            state.repositories = []
            state.selection = nil
            return .none

        case .stopSearchingManifests:
            state.isProcessing = false
            guard environment.settingsDataSource.isAutomaticFetchEnabled else { return .none }

            return Effect(value: AppAction.fetchLicenses)

        case let .updateIsTargeted(isTargeted):
            state.isTargeted = isTargeted
            return .none

        case .resetProgress:
            state.isProcessing = false
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
                return Effect(value: AppAction.updateProgress)
            }

            return .none

        case .didStopFetchingLicenses:
            state.progress = 1.0
            if state.selectedRepository == nil {
                state.selection = state.repositories.first?.id
            }

            return Effect(value: AppAction.resetProgress)
                .delay(for: 1, scheduler: DispatchQueue.main)
                .eraseToEffect()

        case let .didProcess(repository):
            if let index = state.repositories.firstIndex(where: { $0.id == repository.id }) {
                state.repositories[index] = repository
                state.repositories[index].isProcessing = false
            }

            state.remainingRepositories -= 1

            return Effect(value: AppAction.updateProgress)

        case .fetchLicenses:
            return state.repositories
                .filter { $0.license == nil }
                .publisher
                .flatMap(maxPublishers: .max(3)) { repository in
                    Just(repository)
                        .flatMap { (repository: GithubRepository) -> AnyPublisher<GithubRepository, Never> in
                            environment.cocoaPodsProcessor.process(repository: repository)
                                .eraseToAnyPublisher()
                        }
                        .flatMap { repository in
                            environment.licenseProcessor.process(repository: repository)
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

            let csvRows: [[String]] = environment.csvRowFactory.makeRows(from: state.repositories)
            environment.csvExporter.exportCSV(fromRows: csvRows, toDestination: destination)

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
                .collect()
                .receive(on: RunLoop.main)
                .map { urls in urls.compactMap { $0 } }
                .map(AppAction.searchManifests(filePaths:))
                .eraseToEffect()

        case let .selectedRepository(id):
            state.selection = id
            return .none

        case .useExampleManifests:
            guard
                let swiftPmUrl = Bundle.main.url(forResource: "Package", withExtension: "resolved"),
                let cartfileUrl = Bundle.main.url(forResource: "Cartfile", withExtension: "resolved"),
                let cocoapodsUrl = Bundle.main.url(forResource: "Podfile", withExtension: "lock")
            else { return .none }

            return Effect(value: AppAction.searchManifests(filePaths: [swiftPmUrl, cartfileUrl, cocoapodsUrl]))

        case let .searchManifests(filePaths):
            return environment.manifestPublisher(filePaths: filePaths)
                .flatMap { (manifest: Manifest) -> AnyPublisher<GithubRepository, Never> in
                    switch manifest.packageManager {
                    case .swiftPm:
                        return environment.swiftPmDecodingStrategy.decode(content: manifest.content)

                    case .carthage:
                        return environment.carthageDecodingStrategy.decode(content: manifest.content)

                    case .cocoaPods:
                        return environment.cocoaPodsDecodingStrategy.decode(content: manifest.content)
                    }
                }
                .receive(on: RunLoop.main)
                .map(AppAction.add(repository:))
                .prepend(AppAction.startSearchingManifests)
                .append(AppAction.stopSearchingManifests)
                .eraseToEffect()

        case .registerErrorMessageSubscription:
            let errorMessageSubscriptionId: UUID = .init()
            state.errorMessageSubscriptionId = errorMessageSubscriptionId

            return NotificationCenter.default.publisher(for: .errorMessageChanged)
                .flatMap { (notification: Notification) -> AnyPublisher<AppAction, Never> in
                    let errorMessage: String? = notification.userInfo?[String.errorMessageKey] as? String

                    return Just(AppAction.updateErrorMessage(value: errorMessage)).eraseToAnyPublisher()
                }
                .eraseToEffect()
                .cancellable(id: errorMessageSubscriptionId)

        case .unregisterFromErrorMessageSubscription:
            guard let errorMessageSubscriptionId = state.errorMessageSubscriptionId else { return .none }

            return .cancel(id: errorMessageSubscriptionId)

        case .readIsOnboardingCompleted:
            state.isOnboardingCompleted = environment.settingsDataSource.isOnboardingCompleted
            return .none

        case let .updateIsOnboardingCompleted(isOnboardingCompleted):
            environment.settingsDataSource.isOnboardingCompleted = isOnboardingCompleted
            return Effect(value: .readIsOnboardingCompleted)

        case .none:
            return .none
        }
    }
}
