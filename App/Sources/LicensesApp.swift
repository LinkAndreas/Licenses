//  Copyright © 2020 Andreas Link. All rights reserved.

import AppKit
import SwiftUI

@main
struct LicensesApp: App {
    // swiftlint:disable:next weak_delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            WindowContentView()
                .frame(
                    minWidth: 650,
                    idealWidth: 800,
                    maxWidth: .infinity,
                    minHeight: 450,
                    idealHeight: 600,
                    maxHeight: .infinity,
                    alignment: .center
                )
        }

        Settings {
            SettingsView()
        }
    }
}
