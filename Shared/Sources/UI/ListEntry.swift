//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

class ListEntry {
    var id: UUID
    var title: String?
    var detail: String?
    var isProcessing: Bool

    init(
        id: UUID,
        title: String? = nil,
        detail: String? = nil,
        isProcessing: Bool = false
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.isProcessing = isProcessing
    }
}

extension ListEntry: Equatable {
    static func == (lhs: ListEntry, rhs: ListEntry) -> Bool {
        return lhs.id == rhs.id && lhs.isProcessing == rhs.isProcessing
    }
}
