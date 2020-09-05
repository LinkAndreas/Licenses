//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct AppState: Equatable {
    var isProcessing: Bool
    var isTargeted: Bool
    var progress: Float?
    var remainingRepositories: Int = 0
    var totalRepositories: Int = 0
    var errorMessage: String?
    var selectedRepository: GithubRepository?
    var repositories: [GithubRepository]
}

extension AppState {
    var listEntries: [RepositoryListEntry] {
        RepositoryListEntryFactory.makeListEntries(from: repositories)
    }

    var detailListEntries: [RepositoryDetailListEntry]? {
        RepositoryListEntryFactory.makeDetailListEntries(from: selectedRepository)
    }
}
