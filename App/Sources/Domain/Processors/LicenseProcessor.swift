//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum LicenseProcessor {
    static func process(repository: GithubRepository) -> AnyPublisher<GithubRepository, Never> {
        guard
            repository.license == nil,
            let (name, author) = GithubRepositoryUrlDecoder.decode(repositoryURL: repository.url)
        else {
            return Just<GithubRepository>(repository)
                .eraseToAnyPublisher()
        }

        return API.requestMappedModel(
            Github.license(name: name, author: author),
            mapper: GithubLicenseModelMapper.map
        )
        .receive(on: RunLoop.main)
        .map { license in
            let modifiedRepository: GithubRepository = repository
            modifiedRepository.license = license
            return modifiedRepository
        }
        .catch { _ in Just<GithubRepository>(repository) }
        .eraseToAnyPublisher()
    }
}
