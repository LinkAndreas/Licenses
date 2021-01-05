//  Copyright © 2021 Andreas Link. All rights reserved.

import Cocoa
import SwiftUI

class SettingsHostingViewController: NSHostingController<SettingsView> {
    required init?(coder: NSCoder) {
        let rootView = SettingsView()

        super.init(coder: coder, rootView: rootView)
    }
}
