//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum ListEntryFactory {
    static func makeListEntries(from repositories: [GithubRepository]) -> [ListEntry] {
        repositories.map(makeListEntry)
    }

    static func makeListEntry(from repository: GithubRepository) -> ListEntry {
        return .init(
            id: repository.id,
            title: repository.name,
            subtitle: repository.version,
            caption: repository.packageManager.rawValue,
            isProcessing: repository.isProcessing
        )
    }

    static func makeDetailListEntries(from repository: GithubRepository?) -> [RepositoryDetailListEntry]? {
        guard let repository = repository else { return nil }

        var result: [RepositoryDetailListEntry] = []
        result += [
            .init(
                iconName: "tag",
                title: L10n.Detail.ListEntry.Name.title, subtitle: repository.name
            ),
            .init(
                iconName: "version",
                title: L10n.Detail.ListEntry.Version.title, subtitle: repository.version
            ),
            .init(
                iconName: "folder",
                title: L10n.Detail.ListEntry.PackageManager.title, subtitle: repository.packageManager.rawValue
            ),
            repository.author.map {
                .init(
                    iconName: "person",
                    title: L10n.Detail.ListEntry.Author.title,
                    subtitle: $0
                )
            },
            repository.license?.downloadURL.map {
                .init(
                    iconName: "link",
                    title: L10n.Detail.ListEntry.LicenseUrl.title,
                    subtitle: $0
                )
            },
            repository.license?.license?.name.map {
                .init(
                    iconName: "signature",
                    title: L10n.Detail.ListEntry.LicenseName.title,
                    subtitle: $0
                )
            },
            repository.license?.decodedContent.map {
                .init(
                    iconName: "license",
                    title: L10n.Detail.ListEntry.LicenseContent.title,
                    subtitle: $0
                )
            }
        ].compactMap { $0 }
        return result
    }
}
