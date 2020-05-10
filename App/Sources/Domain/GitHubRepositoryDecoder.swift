//  Copyright © 2020 Andreas Link. All rights reserved.

enum GitHubRepositoryDecoder {
    static func decodeRepositories(from artifacts: [Artifact]) -> [GitHubRepository] {
        let repositories: [[GitHubRepository]] = artifacts.map { artifact in
            switch artifact.type {
            case .carthage:
                return CarthageDecodingStrategy.decode(content: artifact.content)

            case .swiftPm:
                return SwiftPmDecodingStrategy.decode(content: artifact.content)
            }
        }

        return [GitHubRepository]((Set<GitHubRepository>(repositories.flatMap({ $0 }))))
    }
}
