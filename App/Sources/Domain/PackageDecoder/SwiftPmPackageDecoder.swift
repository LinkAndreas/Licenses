//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum SwiftPmPackageDecoder {
    static func decode(content: String?) -> [SwiftPmPackage] {
        guard
            let content = content,
            let data = content.data(using: .utf8),
            let resolvedPackages = try? JSONDecoder().decode(ResolvedPackages.self, from: data)
        else {
            return []
        }

        let packages: [SwiftPmPackage] = resolvedPackages.object.pins.compactMap { package in
            guard
                let (name, author) = GitHubRepositoryUrlDecoder.decode(repositoryUrlString: package.repositoryUrl)
            else { return nil }

            return SwiftPmPackage(name: name, author: author, version: package.state.version)
        }

        return packages
    }
}
