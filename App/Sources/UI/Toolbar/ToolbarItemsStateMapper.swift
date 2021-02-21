//  Copyright © 2021 Andreas Link. All rights reserved.

import AppKit

enum ToolbarItemsStateMapper {
    static func map(state: AppState) -> ToolbarItemsState {
        return .init(
            toggleMenuItemState: .init(
                tintColor: NSColor.controlTextColor,
                isDisabled: false,
                hint: L10n.Toolbar.ToggleMenu.tooltip,
                imageSystemName: "sidebar.left"
            ),
            chooseManifestsItemState: .init(
                tintColor: state.isProcessing ? NSColor.disabledControlTextColor : NSColor.controlTextColor,
                isDisabled: state.isProcessing,
                hint: L10n.Toolbar.ImportManifests.tooltip,
                imageSystemName: "folder.badge.plus"
            ),
            refreshItemState: .init(
                tintColor: state.isProcessing ? NSColor.disabledControlTextColor : NSColor.controlTextColor,
                isDisabled: state.isProcessing,
                hint: L10n.Toolbar.FetchLicenses.tooltip,
                imageSystemName: "arrow.clockwise"
            ),
            exportItemState: .init(
                tintColor: state.isProcessing ? NSColor.disabledControlTextColor : NSColor.controlTextColor,
                isDisabled: state.isProcessing,
                hint: L10n.Toolbar.ExportLicenses.tooltip,
                imageSystemName: "square.and.arrow.up"
            )
        )
    }
}
