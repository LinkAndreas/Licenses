//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

@main
struct LicensesApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            FileDropArea {
                ContentView()
            }
            .frame(width: 1200, height: 1200, alignment: .center)
            .navigationTitle(L10n.appName)
            .environmentObject(Store.shared)
            .environmentObject(WindowStore())
        }

        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}
