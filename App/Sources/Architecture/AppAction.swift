//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum AppAction: Equatable {
    case searchManifests(path: URL)
    case processManifests([Manifest])
    case updateRepository(GithubRepository)
    case selectRepository(GithubRepository?)
    case fetchRepositoryMetaDataIfNeeded(GithubRepository?)
    case changeIsTargeted(Bool)
    case updateGithubRequestStatus(GithubRequestStatus)
    case startedProcessing(GithubRepository)
    case stoppedProcessing(GithubRepository)
}
