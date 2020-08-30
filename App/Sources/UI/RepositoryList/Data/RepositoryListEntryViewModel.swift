//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryListEntryViewModel {
    let title: String?
    let subtitle: String?
    let caption: String?
    let showsProgressIndicator: Bool

    init(
        title: String? = nil,
        subtitle: String? = nil,
        caption: String? = nil,
        showsProgressIndicator: Bool = false
    ) {
        self.title = title
        self.subtitle = subtitle
        self.caption = caption
        self.showsProgressIndicator = showsProgressIndicator
    }
}
