//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let rootView = FileDropArea {
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
        .environmentObject(Store.shared)

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )

        window.center()
        window.title = L10n.appName
        window.setFrameAutosaveName("Licenses")
        window.contentView = NSHostingView(rootView: rootView)
        window.makeKeyAndOrderFront(nil)
        window.toolbar = Toolbar.shared.wrappedToolbar
    }

    @IBAction private func openFilePath(_ sender: Any) {
        let openPanel: NSOpenPanel = .init()
        openPanel.title = "Manifest Source"
        openPanel.allowsMultipleSelection = true
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = true
        openPanel.begin { response in
            guard response == .OK else { return }

            Store.shared.searchManifests(at: openPanel.urls)
        }
    }
}
