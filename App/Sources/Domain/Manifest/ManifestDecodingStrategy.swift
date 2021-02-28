//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

protocol ManifestDecodingStrategy {
    func decode(content: String) -> AnyPublisher<GithubRepository, Never>
}
