//  Copyright © 2020 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

enum CocoaPodsTrunk: NetworkTarget {
    case pod(name: String, version: String)
}

extension CocoaPodsTrunk {
    var baseUrl: String { "https://trunk.cocoapods.org/api/v1/" }

    var requestTimeoutInterval: TimeInterval { 30 }

    var usedPlugins: [NetworkPluginType] { [.universal] }

    var path: String {
        switch self {
        case let .pod(name, version):
            return "pods/\(name)/versions/\(version)"
        }
    }

    var method: HttpMethod {
        switch self {
        case .pod:
            return .get
        }
    }

    var task: HttpTask {
        switch self {
        case .pod:
            return .requestPlain
        }
    }
}
