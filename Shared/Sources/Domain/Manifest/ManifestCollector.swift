//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum ManifestCollector {
    static func search(at filePath: URL) -> AnyPublisher<Manifest, Never> {
        let subject: PassthroughSubject<Manifest, Never> = .init()
        DispatchQueue.global(qos: .userInitiated).async {
            var isDirectory: ObjCBool = false
            let fileManager: FileManager = .init()

            guard fileManager.fileExists(atPath: filePath.path, isDirectory: &isDirectory) else {
                return subject.send(completion: .finished)
            }

            if isDirectory.boolValue {
                let enumerator = fileManager.enumerator(at: filePath, includingPropertiesForKeys: nil)
                while let nextFilePath: URL = enumerator?.nextObject() as? URL {
                    guard let manifest = Manifest(fromFilePath: nextFilePath) else { continue }

                    subject.send(manifest)
                }
            } else {
                guard let manifest = Manifest(fromFilePath: filePath) else {
                    return subject.send(completion: .finished)
                }

                subject.send(manifest)
            }

            subject.send(completion: .finished)
        }

        return subject.eraseToAnyPublisher()
    }
}
