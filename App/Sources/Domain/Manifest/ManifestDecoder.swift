//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

enum ManifestDecoder {
    static func decode(_ manifest: Manifest) -> AnyPublisher<GithubRepository, Never> {
        switch manifest.packageManager {
        case .carthage:
            return CarthageManifestDecodingStrategy.decode(content: manifest.content)

        case .swiftPm:
            return SwiftPmManifestDecodingStrategy.decode(content: manifest.content)

        case .cocoaPods:
            return CocoaPodsManifestDecodingStrategy.decode(content: manifest.content)
        }
    }
}
