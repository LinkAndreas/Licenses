//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

struct AppState: Equatable {
    static let initial: Self = .init()

    var errorMessageSubscriptionId: UUID?
    var isOnboardingCompleted: Bool
    var isProcessing: Bool
    var isTargeted: Bool
    var progress: Float?
    var remainingRepositories: Int = 0
    var totalRepositories: Int = 0
    var errorMessage: String?
    var selection: UUID?
    var repositories: [GithubRepository]
    var selectedRepository: GithubRepository? { repositories.first(where: { $0.id == selection }) }

    init(
        errorMessageSubscriptionId: UUID? = nil,
        isProcessing: Bool = false,
        isTargeted: Bool = false,
        progress: Float? = nil,
        remainingRepositories: Int = 0,
        totalRepositories: Int = 0,
        errorMessage: String? = nil,
        selection: UUID? = nil,
        repositories: [GithubRepository] = [],
        settingsDataSource: SettingsSynchronousDataSource = Defaults.shared
    ) {
        self.errorMessageSubscriptionId = errorMessageSubscriptionId
        self.isOnboardingCompleted = settingsDataSource.isOnboardingCompleted
        self.isProcessing = isProcessing
        self.isTargeted = isTargeted
        self.progress = progress
        self.remainingRepositories = remainingRepositories
        self.totalRepositories = totalRepositories
        self.errorMessage = errorMessage
        self.selection = selection
        self.repositories = repositories
    }
}
