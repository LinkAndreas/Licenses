//  Copyright © 2020 Andreas Link. All rights reserved.

enum ManifestDecoder {
    static func decode(_ manifests: [Manifest]) -> [GithubRepository] {
        return manifests.map(decode).flatMap { $0 }
    }

    static func decode(_ manifest: Manifest) -> [GithubRepository] {
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
