//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

struct RepositoryListViewState: Equatable {
    let entries: [RepositoryListEntry]
    let selection: UUID?
}
