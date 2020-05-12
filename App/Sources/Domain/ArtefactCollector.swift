//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

final class ArtefactCollector {
    let dispatchQueue = DispatchQueue(label: "SearchTasks", qos: .userInitiated)

    func search(at path: URL, completion: @escaping (([Artefact]) -> Void)) {
        dispatchQueue.async { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                completion(self.performSearchTask(at: path))
            }
        }
    }

    private func performSearchTask(at path: URL) -> [Artefact] {
        var isDirectory: ObjCBool = false

        let fileManager: FileManager = .init()
        guard fileManager.fileExists(atPath: path.path, isDirectory: &isDirectory) else { return [] }

        if isDirectory.boolValue {
            let enumerator = fileManager.enumerator(at: path, includingPropertiesForKeys: nil)
            return enumerator?.allObjects.compactMap({ $0 as? URL }).compactMap(readContent) ?? []
        } else {
            return readContent(at: path).flatMap { return [$0] } ?? []
        }
    }

    private func readContent(at path: URL) -> Artefact? {
        guard let type: ArtefactType = ArtefactType(fromFileName: path.lastPathComponent) else { return nil }
        guard let content: String = try? String(contentsOf: path, encoding: .utf8) else { return nil }

        return Artefact(type: type, content: content)
    }
}
