//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum CarthageDecodingStrategy: ArtifactDecodingStrategy {
    static func decode(content: String?) -> [GitHubRepository] {
        guard let content = content else { return [] }

        let regex: NSRegularExpression = NSRegularExpression(RegexPatterns.carthage)
        let nsRange: NSRange = .init(location: 0, length: content.count)
        let matches: [NSTextCheckingResult] = regex.matches(in: content, options: [], range: nsRange)

        let result: [GitHubRepository?] = matches.map { match in
            guard match.numberOfRanges == 3 else { return nil }

            let author: String = (content as NSString).substring(with: match.range(at: 1))
            let name: String = (content as NSString).substring(with: match.range(at: 2))

            return GitHubRepository(author: author, name: name)
        }

        return result.compactMap { $0 }
    }
}
