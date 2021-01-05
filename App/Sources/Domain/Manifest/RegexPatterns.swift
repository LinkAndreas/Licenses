//  Copyright © 2021 Andreas Link. All rights reserved.

enum RegexPatterns {
    static let cocoaPods: String = "- (.*) \\(([0-9.]*)\\)"
    static let carthage: String = {
        let pattern = "[\\w\\.\\-]+"
        let quotes = "\""
        return "github \(quotes)(\(pattern))/(\(pattern))\(quotes) \(quotes)(\(pattern))\(quotes)"
    }()
}
