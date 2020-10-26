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
    var scope: [NetworkPluginTargetScope] { [.universal] }
    var path: String { "" }

    var method: HttpMethod {
        switch self {
        case .data:
            return .get
        }
    }

    var requestType: HttpRequestType {
        switch self {
        case .data:
            return .plainRequest
        }
    }
}
