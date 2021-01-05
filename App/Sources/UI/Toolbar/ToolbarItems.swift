//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct ToolbarItems: ToolbarContent {
    let areButtonsEnabled: Bool

    let openFiles: () -> Void
    let fetchLicenses: () -> Void
    let exportLicenses: () -> Void

    var controlColor: Color {
        Color(areButtonsEnabled ? NSColor.controlTextColor : NSColor.disabledControlTextColor)
    }

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigation) {
            Button(
                action: {
                    NSApp.keyWindow?.firstResponder?.tryToPerform(
                        #selector(NSSplitViewController.toggleSidebar(_:)),
                        with: nil
                    )
                },
                label: {
                    Image(systemName: "sidebar.left")
                        .foregroundColor(Color(NSColor.controlTextColor))
                }
            )
            .help(L10n.Toolbar.ToggleMenu.tooltip)
        }

        ToolbarItem(placement: .primaryAction) {
            Button(action: openFiles) {
                Image(systemName: "folder.badge.plus")
                    .foregroundColor(controlColor)
            }
            .help(L10n.Toolbar.ImportManifests.tooltip)
            .disabled(!areButtonsEnabled)
        }
        ToolbarItemGroup(placement: .automatic) {
            Button(action: fetchLicenses) {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(controlColor)
            }
            .disabled(!areButtonsEnabled)
            .help(L10n.Toolbar.FetchLicenses.tooltip)
            Button(action: exportLicenses) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(controlColor)
            }
            .disabled(!areButtonsEnabled)
            .help(L10n.Toolbar.ExportLicenses.tooltip)
        }
    }
}
