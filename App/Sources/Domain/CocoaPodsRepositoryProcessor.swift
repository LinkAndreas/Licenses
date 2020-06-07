//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum CocoaPodsRepositoryProcessor {
    private static func process(repository: GitHubRepository) -> AnyPublisher<GitHubRepository, Error> {
        precondition(
            repository.packageManager == .cocoaPods,
            "The given repository is not a cocoaPods repository"
        )

        return API.call(
            CocoaPodsTrunk.pod(name: repository.name, version: repository.version),
            mapper: TrunkResponseModelMapper.map
        )
        .retry(3)
        .compactMap { $0?.dataURL }
        .flatMap {
            API.call(Generic.data(url: $0), mapper: { (data: Data) in data })
                .retry(3)
        }
        .decode(type: PodSpecEntity.self, decoder: JSONDecoder.default)
        .map { $0.source.git }
        .tryMap { gitHubUrl in
            guard let url = URL(string: gitHubUrl) else { throw DomainError.unexpected }

            var modifiedRepository: GitHubRepository = repository
            modifiedRepository.url = url
            return modifiedRepository
        }
        .eraseToAnyPublisher()
    }
}
