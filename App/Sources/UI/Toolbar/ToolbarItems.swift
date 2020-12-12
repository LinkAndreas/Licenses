//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct ToolbarItems: ToolbarContent {
    let areButtonsEnabled: Bool

    let openFiles: () -> Void
    let fetchLicenses: () -> Void
    let exportLicenses: () -> Void

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
                        .foregroundColor(Color(Asset.Colors.light.color))
                }
            )
        }

        ToolbarItem(placement: .primaryAction) {
            Button(action: openFiles) {
                Image(systemName: "folder.badge.plus")
                    .foregroundColor(Color(Asset.Colors.light.color))
            }
            .help(L10n.Toolbar.ImportManifests.tooltip)
            .disabled(!areButtonsEnabled)
        }
        ToolbarItemGroup(placement: .automatic) {
            Button(action: fetchLicenses) {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(Color(Asset.Colors.light.color))
            }
            .disabled(!areButtonsEnabled)
            .help(L10n.Toolbar.FetchLicenses.tooltip)
            Button(action: exportLicenses) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(Color(Asset.Colors.light.color))
            }
            .disabled(!areButtonsEnabled)
            .help(L10n.Toolbar.ExportLicenses.tooltip)
        }
    }
}
