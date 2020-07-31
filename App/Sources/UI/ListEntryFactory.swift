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
            .init(iconName: "tag", title: "Name: ", subtitle: repository.name),
            .init(iconName: "version", title: "Version: ", subtitle: repository.version),
            .init(iconName: "folder", title: "Package Manager: ", subtitle: repository.packageManager.rawValue),
            repository.author.map { .init(iconName: "person", title: "Author: ", subtitle: $0) },
            repository.license?.downloadURL.map { .init(iconName: "link", title: "License URL: ", subtitle: $0) },
            repository.license?.license?.name.map {
                .init(iconName: "signature", title: "License Name: ", subtitle: $0)
            },
            repository.license?.decodedContent.map {
                .init(iconName: "license", title: "License Content: ", subtitle: $0)
            }
        ].compactMap { $0 }
        return result
    }
}
