//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

class RepositoryDetailListEntry: Identifiable {
    let iconName: String
    let title: String
    let subtitle: String
    var id: UUID

    init(
        iconName: String,
        title: String,
        subtitle: String,
        id: UUID = .init()
    ) {
        self.iconName = iconName
        self.title = title
        self.subtitle = subtitle
        self.id = id
    }
}

extension RepositoryDetailListEntry: Equatable {
    static func == (lhs: RepositoryDetailListEntry, rhs: RepositoryDetailListEntry) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
            && lhs.iconName == rhs.iconName
    }
}
