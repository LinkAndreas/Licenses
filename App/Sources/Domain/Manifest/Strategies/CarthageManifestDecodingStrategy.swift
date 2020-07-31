//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum CarthageManifestDecodingStrategy: ManifestDecodingStrategy {
    static func decode(content: String) -> AnyPublisher<GithubRepository, Never> {
        let subject: PassthroughSubject<GithubRepository, Never> = .init()
        let regex: NSRegularExpression = NSRegularExpression(RegexPatterns.carthage)
        let nsRange: NSRange = .init(location: 0, length: content.count)
        let matches: [NSTextCheckingResult] = regex.matches(in: content, options: [], range: nsRange)

        DispatchQueue.global(qos: .userInitiated).async {
            for match in matches {
                guard match.numberOfRanges == 4 else { continue }

                let name: String = (content as NSString).substring(with: match.range(at: 2))
                let author: String = (content as NSString).substring(with: match.range(at: 1))
                let version: String = makeVersion(from: content, and: match)
                let url: URL = GithubRepositoryUrlEncoder.encode(name: name, author: author)
                let repository: GithubRepository = .init(
                    packageManager: .carthage,
                    name: name,
                    version: version,
                    author: author,
                    url: url
                )

                subject.send(repository)
            }

            subject.send(completion: .finished)
        }

        return subject.eraseToAnyPublisher()
    }
}

extension CarthageManifestDecodingStrategy {
    private static func makeVersion(from content: String, and match: NSTextCheckingResult) -> String {
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
