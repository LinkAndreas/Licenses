//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct ToolbarItems: ToolbarContent {
    @ObservedObject var store: ViewStore<ToolbarItemsState, ToolbarItemsAction>

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
                    Image(systemName: store.toggleMenuItemState.imageSystemName)
                        .foregroundColor(Color(store.toggleMenuItemState.tintColor))
                }
            )
            .help(store.toggleMenuItemState.hint)
            .disabled(store.toggleMenuItemState.isDisabled)
        }

        ToolbarItem(placement: .primaryAction) {
            Button(
                action: {
                    FileImporter.openFiles { filePaths in
                        store.send(.didChooseManifests(filePaths))
                    }
                },
                label: {
                    Image(systemName: store.chooseManifestsItemState.imageSystemName)
                        .foregroundColor(Color(store.chooseManifestsItemState.tintColor))
                }
            )
            .help(store.chooseManifestsItemState.hint)
            .disabled(store.chooseManifestsItemState.isDisabled)
        }
        ToolbarItemGroup(placement: .automatic) {
            Button(
                action: { store.send(.didTriggerRefresh) },
                label: {
                    Image(systemName: store.refreshItemState.imageSystemName)
                        .foregroundColor(Color(store.refreshItemState.tintColor))
                }
            )
            .disabled(store.refreshItemState.isDisabled)
            .help(store.refreshItemState.hint)
            Button(
                action: {
                    FileExporter.exportFile { destination in
                        store.send(.didChooseExportDestination(destination))
                    }
                },
                label: {
                    Image(systemName: store.exportItemState.imageSystemName)
                        .foregroundColor(Color(store.exportItemState.tintColor))
                }
            )
            .disabled(store.exportItemState.isDisabled)
            .help(store.exportItemState.hint)
        }
    }
}
