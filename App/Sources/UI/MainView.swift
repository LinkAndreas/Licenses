//  Copyright © 2020 Andreas Link. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct MainView: View {
    @StateObject private var storeProvider: StoreProvider = .init()

    var body: some View {
        FileDropArea(store: storeProvider.store) {
            WithViewStore(storeProvider.store) { viewStore in
                SplitView(store: storeProvider.store)
                    .toolbar {
                        ToolbarItems(
                            openFiles: {
                                let openPanel: NSOpenPanel = .init()
                                openPanel.title = L10n.Panel.Open.title
                                openPanel.allowsMultipleSelection = true
                                openPanel.canChooseDirectories = true
                                openPanel.canChooseFiles = true
                                openPanel.begin { response in
                                    guard response == .OK else { return }

                                    viewStore.send(.searchManifests(filePaths: openPanel.urls))
                                }
                            },
                            fetchLicenses: { viewStore.send(.fetchLicenses) },
                            exportLicenses: {
                                let savePanel: NSSavePanel = .init()
                                savePanel.title = L10n.Panel.Save.title
                                savePanel.canCreateDirectories = true
                                savePanel.showsTagField = false
                                savePanel.nameFieldStringValue = L10n.Panel.Save.filename
                                savePanel.level = .modalPanel
                                savePanel.begin { result in
                                    guard result == .OK, let destination: URL = savePanel.url else { return }

                                    viewStore.send(.exportLicenses(destination: destination))
                                }
                            }
                        )
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
