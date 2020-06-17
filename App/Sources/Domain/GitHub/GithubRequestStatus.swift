//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct GithubRequestStatus: Equatable {
    var limit: Int
    var remaining: Int
    var resetInterval: TimeInterval
}
