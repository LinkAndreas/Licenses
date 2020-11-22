//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct ToolbarItems: ToolbarContent {
    let areButtonsEnabled: Bool

    let openFiles: () -> Void
    let fetchLicenses: () -> Void
    let exportLicenses: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button(action: openFiles) {
                Image(systemName: "folder.badge.plus")
            }
            .help(L10n.Toolbar.ImportManifests.tooltip)
            .disabled(!areButtonsEnabled)
        }
        ToolbarItemGroup(placement: .automatic) {
            Button(action: fetchLicenses) {
                Image(systemName: "arrow.clockwise")
            }
            .disabled(!areButtonsEnabled)
            .help(L10n.Toolbar.FetchLicenses.tooltip)
            Button(action: exportLicenses) {
                Image(systemName: "square.and.arrow.up")
            }
            .disabled(!areButtonsEnabled)
            .help(L10n.Toolbar.ExportLicenses.tooltip)
        }
    }
}
