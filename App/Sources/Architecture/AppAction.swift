//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum AppAction: Equatable {
    case searchManifests(path: URL)
    case processManifests([Manifest])
    case fetchCocoaPodsMetaData
    case fetchLicenses
    case updateCocoaPodsRepositories([GithubRepository])
    case updateRepositories([GithubRepository])
    case selectRepository(GithubRepository?)
    case changeIsTargeted(Bool)
}
