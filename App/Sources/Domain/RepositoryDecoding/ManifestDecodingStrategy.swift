//  Copyright © 2020 Andreas Link. All rights reserved.

protocol ManifestDecodingStrategy {
    static func decode(content: String) -> [GitHubRepository]
}
