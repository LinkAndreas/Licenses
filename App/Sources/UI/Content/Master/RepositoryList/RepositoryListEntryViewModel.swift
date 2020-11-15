//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryListEntryViewModel: Hashable, Identifiable {
    let id: UUID
    let title: String?
    let subtitle: String?
    let caption: String?
    let showsProgressIndicator: Bool
    let titleColor: NSColor
    let subtitleColor: NSColor
    let captionColor: NSColor

    init(
        id: UUID = .init(),
        title: String? = nil,
        subtitle: String? = nil,
        caption: String? = nil,
        showsProgressIndicator: Bool = false,
        titleColor: NSColor = .white,
        subtitleColor: NSColor = .white,
        captionColor: NSColor = .white
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.caption = caption
        self.showsProgressIndicator = showsProgressIndicator
        self.titleColor = titleColor
        self.subtitleColor = subtitleColor
        self.captionColor = captionColor
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(showsProgressIndicator)
    }
}
