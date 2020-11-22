//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct WindowContentView: View {
    @StateObject private var store: Store<AppState, AppAction, AppEnvironment> = .init(
        initialState: .empty,
        reducer: appReducer,
        environment: .init()
    )

    var body: some View {
        FileDropArea {
            VStack {
                NavigationView {
                    MasterView()
                    DetailView()
                }
                .listStyle(SidebarListStyle())
            }
            .toolbar {
                ToolbarItems(
                    areButtonsEnabled: !store.state.isProcessing,
                    openFiles: {
                        let openPanel: NSOpenPanel = .init()
                        openPanel.title = L10n.Panel.Open.title
                        openPanel.allowsMultipleSelection = true
                        openPanel.canChooseDirectories = true
                        openPanel.canChooseFiles = true
                        openPanel.begin { response in
                            guard response == .OK else { return }

                            store.send(.searchManifests(filePaths: openPanel.urls))
                        }
                    },
                    fetchLicenses: { store.send(.fetchLicenses) },
                    exportLicenses: {
                        let savePanel: NSSavePanel = .init()
                        savePanel.title = L10n.Panel.Save.title
                        savePanel.canCreateDirectories = true
                        savePanel.showsTagField = false
                        savePanel.nameFieldStringValue = L10n.Panel.Save.filename
                        savePanel.level = .modalPanel
                        savePanel.begin { result in
                            guard result == .OK, let destination: URL = savePanel.url else { return }

                            store.send(.exportLicenses(destination: destination))
                        }
                    }
                )
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .errorMessageChanged)) { notification in
            let errorMessage: String? = notification.userInfo?[String.errorMessageKey] as? String

            store.send(.updateErrorMessage(value: errorMessage))
        }
        .environmentObject(store)
    }
}

struct WindowContentView_Previews: PreviewProvider {
    static var previews: some View {
        WindowContentView()
    }
}
