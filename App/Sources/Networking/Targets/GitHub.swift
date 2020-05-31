//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

enum GitHub: NetworkTarget {
    case license(name: String, author: String)
}

extension GitHub {
    var baseUrl: String { "https://api.github.com" }

    var requestTimeoutInterval: TimeInterval { 30 }

    var usedPlugins: [NetworkPluginType] { [.universal] }

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

    var task: HttpTask {
        switch self {
        case .license:
            return .requestPlain
        }
    }
}
