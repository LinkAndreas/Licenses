//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum SwiftPmManifestDecodingStrategy: ManifestDecodingStrategy {
    static func decode(content: String) -> [GitHubRepository] {
        guard
            let data = content.data(using: .utf8),
            let resolvedPackages = try? JSONDecoder().decode(ResolvedPackages.self, from: data)
        else {
            return []
        }

        let repositories: [GitHubRepository] = resolvedPackages.object.pins.compactMap { package in
            guard
                let (name, author) = GitHubRepositoryUrlDecoder.decode(repositoryUrlString: package.repositoryUrl)
            else { return nil }

            return .init(packageManager: .swiftPm, name: name, version: package.state.version, author: author)
        }

        return repositories
    }
}
