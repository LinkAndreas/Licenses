//  Copyright © 2021 Andreas Link. All rights reserved.

import CoreGraphics
import Foundation

struct DetailPlaceholderViewState: Equatable {
    static let empty: Self = .init()

    let title: String
    let subtitle: String
    let entries: [DetailPlaceholderEntry]
    let primaryButtonTitle: String
    let secondaryButtonTitle: String
    let isPrimaryButtonDisabled: Bool
    let isSecondaryButtonDisabled: Bool

    init(
        title: String = "",
        subtitle: String = "",
        entries: [DetailPlaceholderEntry] = [],
        primaryButtonTitle: String = "",
        secondaryButtonTitle: String = "",
        isPrimaryButtonDisabled: Bool = false,
        isSecondaryButtonDisabled: Bool = false
    ) {
        self.title = title
        self.subtitle = subtitle
        self.entries = entries
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.isPrimaryButtonDisabled = isPrimaryButtonDisabled
        self.isSecondaryButtonDisabled = isSecondaryButtonDisabled
    }
}

struct DetailPlaceholderEntry: Equatable, Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let caption: String
    let offset: CGFloat

    init(
        id: UUID = .init(),
        title: String = "",
        subtitle: String = "",
        caption: String = "",
        offset: CGFloat = 0
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.caption = caption
        self.offset = offset
    }
}
