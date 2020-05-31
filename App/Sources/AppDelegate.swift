//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import Combine
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    private var cancellables: Set<AnyCancellable> = .init()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView: some View = ArtefactPickerView()

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.title = "Licenses"
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)

        getLicenses()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        return
    }

    private func getLicenses() {
        let repository: GitHubRepository = .init(
            packageManager: .carthage,
            name: "Eureka",
            version: "5.2.1",
            author: "xmartlabs"
        )

        guard let author = repository.author else { return }

        API.call(GitHub.license(name: repository.name, author: author), mapper: GitHubLicenseModelMapper.map)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { license in
                    print(license.decodedContent ?? "")
                }
            )
            .store(in: &cancellables)
    }
}
