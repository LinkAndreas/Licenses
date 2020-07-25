//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct GithubRequestStatus: Equatable {
    var limit: Int
    var remaining: Int
    var resetInterval: TimeInterval
    var resetIntervalDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]

        if resetInterval >= 3_600 {
            formatter.allowedUnits.insert(.hour)
        }

        return formatter.string(from: resetInterval)!
    }
}
