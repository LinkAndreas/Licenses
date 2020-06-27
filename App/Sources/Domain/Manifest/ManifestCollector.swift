//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum ManifestCollector {
    static private let dispatchQueue: DispatchQueue = .init(label: "ManifestSearchQueue")

    static func search(at filePath: URL) -> AnyPublisher<Manifest, Never> {
        let manifestSubject: PassthroughSubject<Manifest, Never> = .init()
        dispatchQueue.async {
            var isDirectory: ObjCBool = false
            let fileManager: FileManager = FileManager.default

            guard fileManager.fileExists(atPath: filePath.path, isDirectory: &isDirectory) else { return }

            if isDirectory.boolValue {
                let enumerator = fileManager.enumerator(at: filePath, includingPropertiesForKeys: nil)
                while let nextFilePath: URL = enumerator?.nextObject() as? URL {
                    guard let manifest = Manifest(fromFilePath: nextFilePath) else { continue }

                    manifestSubject.send(manifest)
                }
            } else {
                guard let manifest = Manifest(fromFilePath: filePath) else { return }

                manifestSubject.send(manifest)
            }

            manifestSubject.send(completion: .finished)
        }

        return manifestSubject
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
