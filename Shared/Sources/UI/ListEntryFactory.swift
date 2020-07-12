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
}
