//  Copyright © 2020 Andreas Link. All rights reserved.

struct AppState: Equatable {
    static let empty: Self = .init()

    var isProcessing: Bool
    var isTargeted: Bool
    var progress: Float?
    var remainingRepositories: Int = 0
    var totalRepositories: Int = 0
    var errorMessage: String?
    var selectedRepository: GithubRepository?
    var repositories: [GithubRepository]

    init(
        isProcessing: Bool = false,
        isTargeted: Bool = false,
        progress: Float? = nil,
        remainingRepositories: Int = 0,
        totalRepositories: Int = 0,
        errorMessage: String? = nil,
        selectedRepository: GithubRepository? = nil,
        repositories: [GithubRepository] = []
    ) {
        self.isProcessing = isProcessing
        self.isTargeted = isTargeted
        self.progress = progress
        self.remainingRepositories = remainingRepositories
        self.totalRepositories = totalRepositories
        self.errorMessage = errorMessage
        self.selectedRepository = selectedRepository
        self.repositories = repositories
    }
}

extension AppState {
    var masterViewModel: MasterViewModel { MasterViewModelFactory.makeViewModel(from: self) }
    var detailViewModel: DetailViewModel { DetailViewModelFactory.makeViewModel(from: self) }
}
