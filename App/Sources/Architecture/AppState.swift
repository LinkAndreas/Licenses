//  Copyright © 2020 Andreas Link. All rights reserved.

struct AppState: Equatable {
    var repositories: [GithubRepository]
    var selectedRepository: GithubRepository?
    var isTargeted: Bool

    init(repositories: [GithubRepository] = [], isTargeted: Bool = false) {
        self.repositories = repositories
        self.isTargeted = isTargeted
    }
}
