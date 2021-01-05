//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

struct ManifestPublisher: Publisher {
    typealias Output = Manifest
    typealias Failure = Never

    private let subject: PassthroughSubject<Manifest, Never> = .init()
    private let dispatchGroup: DispatchGroup = .init()
    private let dispatchQueue: DispatchQueue = .global(qos: .userInitiated)
    private let filePaths: [URL]

    init(filePaths: [URL] = []) {
        self.filePaths = filePaths
    }

    func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        subject.subscribe(subscriber)

        search(at: filePaths)
    }

    private func search(at filePaths: [URL] = []) {
        filePaths.forEach { filePath in
            dispatchGroup.enter()
            dispatchQueue.async(group: dispatchGroup) {
                defer { self.dispatchGroup.leave() }

                var isDirectory: ObjCBool = false
                let fileManager: FileManager = .init()

                guard fileManager.fileExists(atPath: filePath.path, isDirectory: &isDirectory) else { return }

                if isDirectory.boolValue {
                    let enumerator = fileManager.enumerator(at: filePath, includingPropertiesForKeys: nil)
                    while let nextFilePath: URL = enumerator?.nextObject() as? URL {
                        guard let manifest = Manifest(fromFilePath: nextFilePath) else { continue }

                        self.subject.send(manifest)
                    }
                } else {
                    guard let manifest = Manifest(fromFilePath: filePath) else { return }

                    self.subject.send(manifest)
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.subject.send(completion: .finished)
        }
    }
}
