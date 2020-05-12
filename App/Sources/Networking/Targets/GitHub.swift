//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

enum GitHub: NetworkTarget {
    case license(GitHubRepository)

    var baseURL: URL { URL(string: "https://api.github.com")! }

    var requestTimeoutInterval: TimeInterval { return 30 }

    var path: String {
        switch self {
        case let .license(repository):
            return "/repos/\(repository.author)/\(repository.name)/license"
        }
    }

    var method: HttpMethod {
        switch self {
        case .license:
            return .get
        }
    }

    var task: HttpTask {
        switch self {
        case .license:
            return .requestPlain
        }
    }
}
