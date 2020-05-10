//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum SwiftPmDecodingStrategy: ArtefactDecodingStrategy {
    static func decode(content: String?) -> [GitHubRepository] {
        guard let content = content else { return [] }
        guard let data = content.data(using: .utf8) else { return [] }
        guard let resolvedPackages = try? JSONDecoder().decode(ResolvedPackages.self, from: data) else { return [] }

        return resolvedPackages.object.pins.compactMap { package in
            GitHubRepositoryFactory.makeRepository(from: package.repositoryURL)
        }
    }
}
