//  Copyright © 2020 Andreas Link. All rights reserved.

enum GitHubRepositoryDecoder {
    static func decodeRepositories(from artefacts: [Artefact]) -> [GitHubRepository] {
        let repositories: [[GitHubRepository]] = artefacts.map { artefact in
            switch artefact.type {
            case .carthage:
                return CarthageDecodingStrategy.decode(content: artefact.content)

            case .swiftPm:
                return SwiftPmDecodingStrategy.decode(content: artefact.content)
            }
        }

        return [GitHubRepository]((Set<GitHubRepository>(repositories.flatMap({ $0 }))))
    }
}
