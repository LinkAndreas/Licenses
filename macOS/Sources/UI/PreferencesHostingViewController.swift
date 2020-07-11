//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import SwiftUI

class PreferencesHostingViewController: NSHostingController<SettingsView> {
    required init?(coder: NSCoder) {
        let rootView = SettingsView()

        super.init(coder: coder, rootView: rootView)
    }
}
