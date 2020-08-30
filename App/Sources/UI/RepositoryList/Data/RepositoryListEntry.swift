//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa

class RepositoryListEntry {
    var id: UUID
    var title: String?
    var subtitle: String?
    var caption: String?
    var isProcessing: Bool

    init(
        id: UUID = .init(),
        title: String? = nil,
        subtitle: String? = nil,
        caption: String? = nil,
        isProcessing: Bool = false
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.caption = caption
        self.isProcessing = isProcessing
    }
}

extension RepositoryListEntry: Equatable {
    static func == (lhs: RepositoryListEntry, rhs: RepositoryListEntry) -> Bool {
        return lhs.id == rhs.id && lhs.isProcessing == rhs.isProcessing
    }
}
