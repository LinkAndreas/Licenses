//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import Foundation

enum CocoaPodsRepositoryProcessor {
    static func process(repository: GithubRepository) -> AnyPublisher<GithubRepository, Never> {
        precondition(
            repository.packageManager == .cocoaPods,
            "The given repository is not a cocoaPods repository"
        )

        return API.call(
            CocoaPodsTrunk.pod(name: repository.name, version: repository.version),
            mapper: TrunkResponseModelMapper.map
        )
        .compactMap { $0?.dataURL }
        .flatMap(maxPublishers: .max(1)) {
            API.call(Generic.data(url: $0), mapper: { (entity: PodSpecEntity) in entity })
        }
        .map { $0.source.git }
        .map { repositoryUrl in
            guard let url = URL(string: repositoryUrl) else { return repository }

            var modifiedRepository: GithubRepository = repository
            modifiedRepository.url = url

            if let (name, author) = GithubRepositoryUrlDecoder.decode(repositoryURL: url) {
                modifiedRepository.name = name
                modifiedRepository.author = author
            }

            return modifiedRepository
        }
        .catch { _ in Just<GithubRepository>(repository) }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
