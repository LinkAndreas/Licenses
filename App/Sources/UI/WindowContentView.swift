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
            NavigationView {
                MasterView()
                DetailView(repository: store.state.selectedRepository)
                    .frame(
                        minWidth: 500,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .center
                    )
            }
            .listStyle(SidebarListStyle())
            .toolbar {
                ToolbarItems(
                    areButtonsEnabled: !store.state.isProcessing,
                    openFiles: {
                        FileImporter.openFiles { urls in
                            store.send(.searchManifests(filePaths: urls))
                        }
                    },
                    fetchLicenses: { store.send(.fetchLicenses) },
                    exportLicenses: {
                        FileExporter.exportFile { destination in
                            store.send(.exportLicenses(destination: destination))
                        }
                    }
                )
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .errorMessageChanged)) { notification in
            let errorMessage: String? = notification.userInfo?[String.errorMessageKey] as? String

            guard store.state.errorMessage != errorMessage else { return }

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
