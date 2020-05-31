//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum CocoaPodsPackageDecoder {
    static func decode(content: String?) -> [CocoaPodsPackage] {
        guard
            let content: String = content,
            let versionInfo: [String: String] = makeVersionInfo(from: content)
        else {
            return []
        }

        return versionInfo.map { CocoaPodsPackage(name: $0, version: $1) }
    }

    private static func makeVersionInfo(from content: String) -> [String: String]? {
        guard let regex = try? NSRegularExpression(pattern: RegexPatterns.cocoaPods, options: []) else { return nil }

        let podManifest: NSString = content as NSString
        let range: NSRange = NSRange(location: 0, length: podManifest.length)
        let matches: [NSTextCheckingResult] = regex.matches(in: content, options: [], range: range)
        let versionInfo: [String: String] = matches.reduce([:]) { info, match in
            let numberOfRanges = match.numberOfRanges
            guard numberOfRanges == 3 else {
                assert(false, "maybe invalid regular expression to: \(podManifest.substring(with: match.range))")
                return info
            }

            let name: String = podManifest.substring(with: match.range(at: 1))
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
