//  Copyright © 2021 Andreas Link. All rights reserved.

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
                    minWidth: 1_000,
                    idealWidth: 1_200,
                    minHeight: 650,
                    idealHeight: 800,
                    alignment: .center
                )
        }

        Settings {
            SettingsView()
        }
    }
}
