//  Copyright © 2020 Andreas Link. All rights reserved.

import AppKit

enum FileExporter {
    static func exportFile(completion: @escaping (URL) -> Void) {
        let savePanel: NSSavePanel = .init()
        savePanel.title = L10n.Panel.Save.title
        savePanel.canCreateDirectories = true
        savePanel.showsTagField = false
        savePanel.nameFieldStringValue = L10n.Panel.Save.filename
        savePanel.level = .modalPanel
        savePanel.begin { result in
            guard result == .OK, let destination: URL = savePanel.url else { return }

            completion(destination)
        }
    }
}
