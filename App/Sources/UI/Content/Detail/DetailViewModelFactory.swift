//  Copyright © 2020 Andreas Link. All rights reserved.

enum DetailViewModelFactory {
    static func makeViewModel(from state: AppState) -> DetailViewModel {
        return .init(detailListEntries: makeDetailListEntries(from: state))
    }
}

extension DetailViewModelFactory {
    private static func makeDetailListEntries(from state: AppState) -> [RepositoryDetailListEntry]? {
        guard let selectedRepository = state.selectedRepository else { return nil }

        var result: [RepositoryDetailListEntry] = []
        result += [
            .init(
                iconName: "tag",
                title: L10n.Detail.ListEntry.Name.title,
                subtitle: selectedRepository.name
            ),
            .init(
                iconName: "version",
                title: L10n.Detail.ListEntry.Version.title,
                subtitle: selectedRepository.version
            ),
            .init(
                iconName: "folder",
                title: L10n.Detail.ListEntry.PackageManager.title,
                subtitle: selectedRepository.packageManager.rawValue
            ),
            selectedRepository.author.map {
                .init(
                    iconName: "person",
                    title: L10n.Detail.ListEntry.Author.title,
                    subtitle: $0
                )
            },
            selectedRepository.license?.downloadURL.map {
                .init(
                    iconName: "link",
                    title: L10n.Detail.ListEntry.LicenseUrl.title,
                    subtitle: $0
                )
            },
            selectedRepository.license?.license?.name.map {
                .init(
                    iconName: "signature",
                    title: L10n.Detail.ListEntry.LicenseName.title,
                    subtitle: $0
                )
            },
            selectedRepository.license?.decodedContent.map {
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
