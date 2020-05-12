//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import Combine
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    var cancellables: Set<AnyCancellable> = .init()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 400),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: ContentView())
        window.makeKeyAndOrderFront(nil)

        getLicenses()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        return
    }

    private func getLicenses() {
        guard
            let repository: GitHubRepository = GitHubRepository(author: "xmartlabs", name: "Eureka")
        else { return }

        API.call(GitHub.license(repository), mapper: GitHubLicenseModelMapper.map)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { license in
                    print(license)
                }
            )
            .store(in: &cancellables)
    }
}
