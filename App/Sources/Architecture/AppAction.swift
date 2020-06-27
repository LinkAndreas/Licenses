//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum AppAction: Equatable {
    case searchManifests(path: URL)
    case addRepository(GithubRepository)
    case finishedProcessingRepository(GithubRepository, Float)
    case setProgress(Float?)
    case selectRepository(GithubRepository?)
    case fetchLicenses
    case changeIsTargeted(Bool)
    case updateGithubRequestStatus(GithubRequestStatus)
    case startedProcessing(GithubRepository)
    case stoppedProcessing(GithubRepository)
}
