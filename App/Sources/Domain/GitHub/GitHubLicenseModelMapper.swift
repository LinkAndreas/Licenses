//  Copyright © 2020 Andreas Link. All rights reserved.

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
            content: entity.content,
            encoding: entity.encoding,
            links: LinksModelMapper.map(from: entity.links),
            license: LicenseModelMapper.map(from: entity.license)
        )
    }
}
