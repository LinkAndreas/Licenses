//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum GithubRequestStatusFactory {
    static func make(from headerFields: [AnyHashable: Any]) -> GithubRequestStatus? {
        guard
            let limitString: String = headerFields["X-RateLimit-Limit"] as? String,
            let remainingString: String = headerFields["X-RateLimit-Remaining"] as? String,
            let resetIntervalString: String = headerFields["X-RateLimit-Reset"] as? String,
            let limit: Int = Int(limitString),
            let remaining: Int = Int(remainingString),
            let resetInterval: TimeInterval = TimeInterval(resetIntervalString)
        else {
            return nil
        }

        return .init(limit: limit, remaining: remaining, resetInterval: resetInterval)
    }
}
