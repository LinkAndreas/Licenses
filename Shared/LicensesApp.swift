//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

@main
struct LicensesApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            FileDropArea {
                ContentView()
            }
            .frame(
                minWidth: 650,
                idealWidth: 800,
                maxWidth: .infinity,
                minHeight: 300,
                idealHeight: 600,
                maxHeight: .infinity,
                alignment: .center
            )
            .navigationTitle(L10n.appName)
            .environmentObject(GlobalStore.shared)
            .environmentObject(LocalStore())
        }

        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}
