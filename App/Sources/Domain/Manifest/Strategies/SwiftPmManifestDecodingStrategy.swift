//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

enum SwiftPmManifestDecodingStrategy: ManifestDecodingStrategy {
    static func decode(content: String) -> AnyPublisher<GithubRepository, Never> {
        let subject: PassthroughSubject<GithubRepository, Never> = .init()

        guard
            let data = content.data(using: .utf8),
            let resolvedPackages = try? JSONDecoder().decode(ResolvedPackagesEntity.self, from: data)
        else {
            return Empty<GithubRepository, Never>().eraseToAnyPublisher()
        }

        DispatchQueue.global(qos: .userInitiated).async {
            for package in resolvedPackages.object.pins {
                guard
                    let (name, author) = GithubRepositoryUrlDecoder.decode(repositoryUrlString: package.repositoryUrl)
                else { return }

                let url: URL = GithubRepositoryUrlEncoder.encode(name: name, author: author)

                let repository: GithubRepository = .init(
                    packageManager: .swiftPm,
                    name: name,
                    version: package.state.version,
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
