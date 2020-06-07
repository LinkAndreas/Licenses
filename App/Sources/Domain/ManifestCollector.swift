//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

final class ManifestCollector {
    let dispatchQueue = DispatchQueue(label: "SearchTasks", qos: .userInitiated)

    func search(at path: URL) -> AnyPublisher<[Manifest], Never> {
        performSearchTask(at: path)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    private func performSearchTask(at filePath: URL) -> Future<[Manifest], Never> {
        var isDirectory: ObjCBool = false
        let fileManager: FileManager = .init()

        return Future<[Manifest], Never> { resolve in
            guard
                fileManager.fileExists(atPath: filePath.path, isDirectory: &isDirectory)
            else {
                return resolve(.success([]))
            }

            if isDirectory.boolValue {
                let enumerator = fileManager.enumerator(at: filePath, includingPropertiesForKeys: nil)
                resolve(.success(enumerator?.allObjects.compactMap({ $0 as? URL }).compactMap(Manifest.init) ?? []))
            } else {
                resolve(.success(Manifest(fromFilePath: filePath).flatMap { return [$0] } ?? []))
            }
        }
    }
}
