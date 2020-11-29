//  Copyright © 2020 Andreas Link. All rights reserved.

import AppKit

enum FileImporter {
    static func openFiles(completion: @escaping ([URL]) -> Void) {
        let openPanel: NSOpenPanel = .init()
        openPanel.title = L10n.Panel.Open.title
        openPanel.allowsMultipleSelection = true
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = true
        openPanel.begin { response in
            guard response == .OK else { return }

            completion(openPanel.urls)
        }
    }
}
