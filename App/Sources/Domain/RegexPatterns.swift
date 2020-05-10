//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum RegexPatterns {
    static let carthage: String = {
        let pattern = "[\\w\\.\\-]+"
        let quotes = "\""
        return "github \(quotes)(\(pattern))/(\(pattern))\(quotes)"
    }()
}
