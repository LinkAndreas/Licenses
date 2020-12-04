//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct WindowContentView: View {
    @StateObject private var store: Store<AppState, AppAction, AppEnvironment> = .init(
        initialState: .empty,
        reducer: appReducer,
        environment: .init()
    )

    @State private var selection: UUID?
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted: Bool = false

    var body: some View {
        FileDropArea {
            NavigationView {
                MasterView(selection: $selection)
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color(Asset.Colors.sidebarGradientTop.color),
                                    Color(Asset.Colors.sidebarGradientBottom.color)
                                ]
                            ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

                DetailView(repository: store.state.repositories.first(where: { $0.id == selection }))
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color(Asset.Colors.backgroundGradientTop.color),
                                    Color(Asset.Colors.backgroundGradientBottom.color)
                                ]
                            ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
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
        .sheet(
            isPresented: Binding(
                get: { !isOnboardingCompleted },
                set: { isOnboardingCompleted = !$0 }
            ),
            content: {
                OnboardingView {
                    isOnboardingCompleted = true
                }
                .frame(width: 250, height: 250, alignment: .center)
            }
        )
    }
}

struct WindowContentView_Previews: PreviewProvider {
    static var previews: some View {
        WindowContentView()
    }
}
