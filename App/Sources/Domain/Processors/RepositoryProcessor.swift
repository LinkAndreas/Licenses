//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine

protocol RepositoryProcessor {
    func process(repository: GithubRepository) -> AnyPublisher<GithubRepository, Never>
}
