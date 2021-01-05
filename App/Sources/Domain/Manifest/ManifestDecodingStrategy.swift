//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

protocol ManifestDecodingStrategy {
    static func decode(content: String) -> AnyPublisher<GithubRepository, Never>
}
