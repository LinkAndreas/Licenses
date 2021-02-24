//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

@main
struct LicensesApp: App {
    // swiftlint:disable:next weak_delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            WindowContentContainerView()
                .frame(
                    minWidth: 1_000,
                    idealWidth: 1_200,
                    minHeight: 650,
                    idealHeight: 800,
                    alignment: .center
                )
        }.commands {
            CommandGroup(after: .help) {
                Button(L10n.PrivacyPolicy.title) {
                    guard let url = URL(string: L10n.PrivacyPolicy.url) else { return }

                    NSWorkspace.shared.open(url)
                }
            }
        }

        Settings {
            SettingsContainerView()
        }
    }
}
