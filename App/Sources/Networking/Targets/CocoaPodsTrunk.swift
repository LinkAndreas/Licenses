//  Copyright © 2021 Andreas Link. All rights reserved.

import Aphrodite
import Foundation

enum CocoaPodsTrunk: NetworkTarget {
    case pod(name: String, version: String)
}

extension CocoaPodsTrunk {
    var baseUrl: String { "https://trunk.cocoapods.org/api/v1/" }

    var requestTimeoutInterval: TimeInterval { 30 }

    var scope: [NetworkPluginTargetScope] { [.universal] }

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

    var requestType: HttpRequestType {
        switch self {
        case .pod:
            return .plainRequest
        }
    }
}
