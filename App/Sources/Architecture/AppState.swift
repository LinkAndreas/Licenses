//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct AppState: Equatable {
    var isTargeted: Bool
    var repositories: [GithubRepository]
    var selectedRepository: GithubRepository?
    var githubRequestStatus: GithubRequestStatus?
    var progress: Float?
    var processingUUIDs: Set<UUID>

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
}
