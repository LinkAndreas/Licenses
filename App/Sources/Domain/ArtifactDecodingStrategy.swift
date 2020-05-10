//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

protocol ArtifactDecodingStrategy {
    static func decode(content: String?) -> [GitHubRepository]
}
