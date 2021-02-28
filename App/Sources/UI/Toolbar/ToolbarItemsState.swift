//  Copyright © 2021 Andreas Link. All rights reserved.

import AppKit

struct ToolbarItemsState: Equatable {
    let toggleMenuItemState: ToolbarItemState
    let chooseManifestsItemState: ToolbarItemState
    let refreshItemState: ToolbarItemState
    let exportItemState: ToolbarItemState
}

struct ToolbarItemState: Equatable {
    let tintColor: NSColor
    let isDisabled: Bool
    let hint: String
    let imageSystemName: String
}
