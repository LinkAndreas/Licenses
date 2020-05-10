//  Copyright © 2020 Andreas Link. All rights reserved.

protocol ArtefactDecodingStrategy {
    static func decode(content: String?) -> [GitHubRepository]
}
