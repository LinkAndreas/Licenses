//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryListEntry: Hashable, Identifiable, Equatable {
    let id: UUID
    let title: String?
    let subtitle: String?
    let caption: String?
    let showsProgressIndicator: Bool
    let isSelected: Bool

    init(
        id: UUID = .init(),
        title: String? = nil,
        subtitle: String? = nil,
        caption: String? = nil,
        showsProgressIndicator: Bool = false,
        isSelected: Bool = false
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.caption = caption
        self.showsProgressIndicator = showsProgressIndicator
        self.isSelected = isSelected
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(showsProgressIndicator)
    }
}
