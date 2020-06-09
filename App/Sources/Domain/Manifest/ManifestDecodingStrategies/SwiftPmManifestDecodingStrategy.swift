//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum SwiftPmManifestDecodingStrategy: ManifestDecodingStrategy {
    static func decode(content: String) -> [GithubRepository] {
        guard
            let data = content.data(using: .utf8),
            let resolvedPackages = try? JSONDecoder().decode(ResolvedPackages.self, from: data)
        else {
            return []
        }

        let repositories: [GithubRepository] = resolvedPackages.object.pins.compactMap { package in
            guard
                let (name, author) = GithubRepositoryUrlDecoder.decode(repositoryUrlString: package.repositoryUrl)
            else { return nil }

            let url: URL = GithubRepositoryUrlEncoder.encode(name: name, author: author)

            return .init(packageManager: .swiftPm, name: name, version: package.state.version, author: author, url: url)
        }

        return repositories
    }
}
