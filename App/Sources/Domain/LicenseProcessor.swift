//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum LicenseProcessor {
    private static func process(repository: GitHubRepository) -> AnyPublisher<GitHubRepository, DomainError> {
        guard let author = repository.author else {
            return Fail(error: DomainError.unexpected)
                .eraseToAnyPublisher()
        }

        return API.call(GitHub.license(name: repository.name, author: author), mapper: GitHubLicenseModelMapper.map)
            .retry(3)
            .map { gitHubLicense in
                var modifiedRepository: GitHubRepository = repository
                modifiedRepository.license = gitHubLicense
                return modifiedRepository
            }
            .eraseToAnyPublisher()
    }
}
