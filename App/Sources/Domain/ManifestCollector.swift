//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

final class ManifestCollector {
    let dispatchQueue = DispatchQueue(label: "SearchTasks", qos: .userInitiated)

    func search(at path: URL, completion: @escaping (([Manifest]) -> Void)) {
        dispatchQueue.async { [weak self] in
            guard let self = self else { return }

            let manifests: [Manifest] = self.performSearchTask(at: path)
            DispatchQueue.main.async {
                completion(manifests)
            }
        }
    }

    private func performSearchTask(at filePath: URL) -> [Manifest] {
        var isDirectory: ObjCBool = false

        let fileManager: FileManager = .init()
        guard fileManager.fileExists(atPath: filePath.path, isDirectory: &isDirectory) else { return [] }

        if isDirectory.boolValue {
            let enumerator = fileManager.enumerator(at: filePath, includingPropertiesForKeys: nil)
            return enumerator?.allObjects.compactMap({ $0 as? URL }).compactMap(Manifest.init) ?? []
        } else {
            return Manifest(fromFilePath: filePath).flatMap { return [$0] } ?? []
        }
    }
}
