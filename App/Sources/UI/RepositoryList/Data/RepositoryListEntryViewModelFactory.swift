//  Copyright © 2020 Andreas Link. All rights reserved.

enum RepositoryListEntryViewModelFactory {
    static func makeViewModel(from entry: RepositoryListEntry) -> RepositoryListEntryViewModel {
        return .init(
            title: entry.title,
            subtitle: entry.subtitle,
            caption: entry.caption,
            showsProgressIndicator: entry.isProcessing
        )
    }
}
