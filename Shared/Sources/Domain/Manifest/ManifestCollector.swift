//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum ManifestCollector {
    static func search(at filePaths: [URL]) -> AnyPublisher<Manifest, Never> {
        let subject: PassthroughSubject<Manifest, Never> = .init()
        let dispatchGroup: DispatchGroup = .init()
        let dispatchQueue: DispatchQueue = .global(qos: .userInitiated)

        filePaths.forEach { filePath in
            dispatchGroup.enter()
            dispatchQueue.async(group: dispatchGroup) {
                defer { dispatchGroup.leave() }

                var isDirectory: ObjCBool = false
                let fileManager: FileManager = .init()

                guard fileManager.fileExists(atPath: filePath.path, isDirectory: &isDirectory) else { return }

                if isDirectory.boolValue {
                    let enumerator = fileManager.enumerator(at: filePath, includingPropertiesForKeys: nil)
                    while let nextFilePath: URL = enumerator?.nextObject() as? URL {
                        guard let manifest = Manifest(fromFilePath: nextFilePath) else { continue }

                        subject.send(manifest)
                    }
                } else {
                    guard let manifest = Manifest(fromFilePath: filePath) else { return }

                    subject.send(manifest)
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            subject.send(completion: .finished)
        }

        return subject.eraseToAnyPublisher()
    }
}
