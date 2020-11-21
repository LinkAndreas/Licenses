//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct MainView: View {
    @StateObject private var store: Store<AppState, AppAction, AppEnvironment> = .init(
        initialState: .init(
            isProcessing: false,
            isTargeted: false,
            progress: nil,
            remainingRepositories: 0,
            totalRepositories: 0,
            errorMessage: nil,
            selectedRepository: nil,
            repositories: []
        ),
        reducer: appReducer,
        environment: .init()
    )

    var body: some View {
        FileDropArea {
            SplitView()
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
            guard let errorMessage: String = notification.userInfo?[String.errorMessageKey] as? String else { return }

            store.send(.updateErrorMessage(value: errorMessage))
        }
        .environmentObject(store)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}