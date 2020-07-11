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
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )

        window.center()
        window.title = L10n.appName
        window.setFrameAutosaveName("Licenses")
        window.contentView = NSHostingView(rootView: rootView)
        window.makeKeyAndOrderFront(nil)
        window.toolbar = .init()

        let toolbarContent = ToolbarContent()
            .environmentObject(Store.shared)

        let toolbarContainer: NSHostingView = .init(rootView: toolbarContent)
        toolbarContainer.frame.size = toolbarContainer.fittingSize

        let titleBarAccessory: NSTitlebarAccessoryViewController = .init()
        titleBarAccessory.view = toolbarContainer
        titleBarAccessory.layoutAttribute = .trailing
        window.addTitlebarAccessoryViewController(titleBarAccessory)
    }
}
