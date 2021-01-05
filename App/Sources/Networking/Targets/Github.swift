//  Copyright © 2021 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

enum Github: NetworkTarget {
    case license(name: String, author: String)
}

extension Github {
    var baseUrl: String { "https://api.github.com" }

    var requestTimeoutInterval: TimeInterval { 30 }

    var scope: [NetworkPluginTargetScope] { [.universal, .github] }

    var path: String {
        switch self {
        case let .license(name, author):
            return "/repos/\(author)/\(name)/license"
        }
    }

    var method: HttpMethod {
        switch self {
        case .license:
            return .get
        }
    }

    var requestType: HttpRequestType {
        switch self {
        case .license:
            return .plainRequest
        }
    }
}
