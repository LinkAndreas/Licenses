//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum GitHubLicenseModelMapper {
    static func map(from entity: GitHubLicenseEntity) -> GitHubLicense {
        return .init(
            name: entity.name,
            path: entity.path,
            sha: entity.sha,
            size: entity.size,
            url: entity.url,
            htmlURL: entity.htmlURL,
            gitURL: entity.gitURL,
            downloadURL: entity.downloadURL,
            type: entity.type,
            decodedContent: decode(content: entity.content),
            links: LinksModelMapper.map(from: entity.links),
            license: LicenseModelMapper.map(from: entity.license)
        )
    }
}

extension GitHubLicenseModelMapper {
    private static func decode(content: String?) -> String? {
        guard
            let content: String = content,
            let data: Data = Data(base64Encoded: content, options: [.ignoreUnknownCharacters])
        else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }
}
