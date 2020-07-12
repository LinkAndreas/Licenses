//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum RepositoryListEntryViewModelFactory {
    static func makeViewModel(from entry: ListEntry) -> RepositoryListEntryViewModel {
        return .init(
            title: entry.title,
            subtitle: entry.subtitle,
            caption: entry.caption,
            showsProgressIndicator: entry.isProcessing
        )
    }
}
