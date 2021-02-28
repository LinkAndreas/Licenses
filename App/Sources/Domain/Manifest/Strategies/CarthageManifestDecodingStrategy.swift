//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

struct CarthageManifestDecodingStrategy: ManifestDecodingStrategy {
    func decode(content: String) -> AnyPublisher<GithubRepository, Never> {
        let regex: NSRegularExpression = NSRegularExpression(RegexPatterns.carthage)
        let nsRange: NSRange = .init(location: 0, length: content.count)
        let matches: [NSTextCheckingResult] = regex.matches(in: content, options: [], range: nsRange)

        return matches.publisher.compactMap { (match: NSTextCheckingResult) -> GithubRepository? in
            guard match.numberOfRanges == 4 else { return nil }

            let name: String = (content as NSString).substring(with: match.range(at: 2))
            let author: String = (content as NSString).substring(with: match.range(at: 1))
            let version: String = makeVersion(from: content, and: match)
            let url: URL = GithubRepositoryUrlEncoder.encode(name: name, author: author)

            return .init(
                packageManager: .carthage,
                name: name,
                version: version,
                author: author,
                url: url
            )
        }
        .subscribe(on: DispatchQueue.global(qos: .userInitiated))
        .eraseToAnyPublisher()
    }
}

extension CarthageManifestDecodingStrategy {
    private func makeVersion(from content: String, and match: NSTextCheckingResult) -> String {
        let version: String = (content as NSString).substring(with: match.range(at: 3))
        let pattern: NSRegularExpression = NSRegularExpression("\\w{40}")
        let matches: [NSTextCheckingResult] = pattern.matches(
            in: version,
            options: [],
            range: NSRange(location: 0, length: (version as NSString).length)
        )

        return matches.isEmpty ? version : String(version.prefix(7))
    }
}
