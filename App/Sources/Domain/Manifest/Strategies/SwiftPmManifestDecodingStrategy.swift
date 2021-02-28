//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

struct SwiftPmManifestDecodingStrategy: ManifestDecodingStrategy {
    func decode(content: String) -> AnyPublisher<GithubRepository, Never> {
        guard
            let data = content.data(using: .utf8),
            let resolvedPackages = try? JSONDecoder().decode(ResolvedPackagesEntity.self, from: data)
        else {
            return Empty<GithubRepository, Never>().eraseToAnyPublisher()
        }

        return resolvedPackages
            .object
            .pins
            .publisher
            .compactMap { (package: PinEntity) -> GithubRepository? in
                guard
                    let (name, author) = GithubRepositoryUrlDecoder.decode(repositoryUrlString: package.repositoryUrl)
                else { return nil }

                let url: URL = GithubRepositoryUrlEncoder.encode(name: name, author: author)

                return .init(
                    packageManager: .swiftPm,
                    name: name,
                    version: package.state.version,
                    author: author,
                    url: url
                )
            }
            .eraseToAnyPublisher()
    }
}
