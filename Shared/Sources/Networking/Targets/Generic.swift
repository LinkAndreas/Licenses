//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

enum Generic: NetworkTarget {
    case data(url: URL)
}

extension Generic {
    var baseUrl: String {
        switch self {
        case let .data(url):
            return url.absoluteString
        }
    }

    var requestTimeoutInterval: TimeInterval { 30 }
    var usedPlugins: [NetworkPluginType] { [.universal] }
    var path: String { "" }

    var method: HttpMethod {
        switch self {
        case .data:
            return .get
        }
    }

    var task: HttpTask {
        switch self {
        case .data:
            return .requestPlain
        }
    }
}
