//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

struct CocoaPodsManifestDecodingStrategy: ManifestDecodingStrategy {
    func decode(content: String) -> AnyPublisher<GithubRepository, Never> {
        return makeVersionInfo(from: content)
            .reduce([]) { array, entry in array + [entry] }
            .map { (name: String, version: String) in
                GithubRepository(packageManager: .cocoaPods, name: name, version: version)
            }
            .publisher
            .eraseToAnyPublisher()
    }
}

extension CocoaPodsManifestDecodingStrategy {
    private func makeVersionInfo(from content: String) -> [String: String] {
        guard let regex = try? NSRegularExpression(pattern: RegexPatterns.cocoaPods, options: []) else { return [:] }

        let podManifest: NSString = content as NSString
        let range: NSRange = NSRange(location: 0, length: podManifest.length)
        let matches: [NSTextCheckingResult] = regex.matches(in: content, options: [], range: range)
        let versionInfo: [String: String] = matches.reduce([:]) { info, match in
            let numberOfRanges = match.numberOfRanges
            guard numberOfRanges == 3 else {
                assert(false, "maybe invalid regular expression to: \(podManifest.substring(with: match.range))")
                return info
            }

            guard
                let name: String = podManifest.substring(with: match.range(at: 1)).components(separatedBy: "/").first
            else { return info }

            let version: String = podManifest.substring(with: match.range(at: 2))

            var info = info
            info[name] = version

            if let prefix = name.components(separatedBy: "/").first, info[prefix] == nil {
                info[prefix] = version
            }

            return info
        }

        return versionInfo
    }
}
