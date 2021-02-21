//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

struct DetailListViewState: Equatable {
    let items: [DetailItem]

    init(items: [DetailItem] = []) {
        self.items = items
    }
}

struct DetailItem: Equatable, Identifiable {
    let id: UUID
    let title: String
    let content: String

    init(
        id: UUID = .init(),
        title: String = "",
        content: String = ""
    ) {
        self.id = id
        self.title = title
        self.content = content
    }
}
