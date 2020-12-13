//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum RepositoryListEntryFactory {
    static func makeListEntries(from state: AppState) -> [RepositoryListEntry] {
        return state.repositories.map { repository in
            return .init(
                id: repository.id,
                title: repository.name,
                subtitle: repository.version,
                caption: repository.packageManager.rawValue,
                showsProgressIndicator: repository.isProcessing
            )
        }
    }
}
