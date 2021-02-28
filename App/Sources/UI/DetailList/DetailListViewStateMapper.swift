//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

enum DetailListViewStateMapper {
    static func map(state: AppState) -> DetailListViewState? {
        guard let selectedRepository = state.selectedRepository else { return nil }

        return .init(items: makeItems(from: selectedRepository))
    }
}

extension DetailListViewStateMapper {
    private static func makeItems(from repository: GithubRepository) -> [DetailItem] {
        return [
            .init(
                title: L10n.Detail.ListEntry.Name.title,
                content: repository.name
            ),
            .init(
                title: L10n.Detail.ListEntry.Version.title,
                content: repository.version
            ),
            .init(
                title: L10n.Detail.ListEntry.PackageManager.title,
                content: repository.packageManager.rawValue
            ),
            repository.author.map { author in
                .init(
                    title: L10n.Detail.ListEntry.Author.title,
                    content: author
                )
            },
            repository.license?.license?.name.map { name in
                .init(
                    title: L10n.Detail.ListEntry.LicenseName.title,
                    content: name
                )
            },
            repository.license?.downloadURL.flatMap(URL.init(string:)).flatMap { url in
                .init(
                    title: L10n.Detail.ListEntry.LicenseUrl.title,
                    content: url.absoluteString
                )
            },
            repository.license?.decodedContent.map { content in
                .init(
                    title: L10n.Detail.ListEntry.LicenseContent.title,
                    content: content
                )
            }
        ].compactMap { $0 }
    }
}
