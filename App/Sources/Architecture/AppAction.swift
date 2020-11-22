//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum AppAction: Equatable {
    case updateErrorMessage(value: String?)
    case resetProgress
    case updateProgress
    case didStartFetchingLicenses
    case didStopFetchingLicenses
    case didProcess(repository: GithubRepository)
    case selectedRepository(id: UUID?)
    case startSearchingManifests
    case stopSearchingManifests
    case searchManifests(filePaths: [URL])
    case add(repository: GithubRepository)
    case handle(providers: [NSItemProvider])
    case fetchLicenses
    case exportLicenses(destination: URL)
    case updateIsTargeted(value: Bool)
}
