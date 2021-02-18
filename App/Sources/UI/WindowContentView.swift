//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct WindowContentView: View {
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted: Bool = false
    @StateObject private var store: Store<AppState, AppAction, AppEnvironment> = .init(
        initialState: .empty,
        reducer: appReducer,
        environment: DefaultEnvironment()
    )

    var body: some View {
        FileDropArea {
            NavigationView {
                MasterView()
                    .listStyle(SidebarListStyle())
                DetailView()
            }
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
        .sheet(
            isPresented: Binding(
                get: { !isOnboardingCompleted },
                set: { isOnboardingCompleted = !$0 }
            ),
            content: {
                OnboardingView {
                    isOnboardingCompleted = true
                }
            }
        )
    }
}

struct WindowContentView_Previews: PreviewProvider {
    static var previews: some View {
        WindowContentView()
    }
}
