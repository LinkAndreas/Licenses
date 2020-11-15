//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct ToolbarItems: ToolbarContent {
    let openFiles: () -> Void
    let fetchLicenses: () -> Void
    let exportLicenses: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button(action: openFiles) {
                Image(systemName: "folder.badge.plus")
            }.help("Import manifests...")
        }
        ToolbarItemGroup(placement: .automatic) {
            Button(action: fetchLicenses) {
                Image(systemName: "arrow.clockwise")
            }
            .help(L10n.Toolbar.FetchLicenses.title)
            Button(action: exportLicenses) {
                Image(systemName: "square.and.arrow.up")
            }
            .help(L10n.Toolbar.ExportLicenses.title)
        }
    }
}
