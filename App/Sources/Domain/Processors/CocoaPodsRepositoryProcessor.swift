//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import Foundation

struct CocoaPodsRepositoryProcessor: RepositoryProcessor {
    func process(repository: GithubRepository) -> AnyPublisher<GithubRepository, Never> {
        guard repository.packageManager == .cocoaPods, repository.url == nil else {
            return Just(repository).eraseToAnyPublisher()
        }

        return API.requestMappedModel(
            CocoaPodsTrunk.pod(name: repository.name, version: repository.version),
            mapper: TrunkResponseModelMapper.map
        )
        .compactMap { $0?.dataURL }
        .flatMap(maxPublishers: .max(1)) {
            API.requestMappedModel(
                Generic.data(url: $0),
                mapper: { (entity: PodSpecEntity) in entity }
            )
        }
        .map(\.source.git)
        .map { repositoryUrl in
            guard let url = URL(string: repositoryUrl) else { return repository }

            let modifiedRepository: GithubRepository = repository
            modifiedRepository.url = url

            if let (name, author) = GithubRepositoryUrlDecoder.decode(repositoryURL: url) {
                modifiedRepository.name = name
                modifiedRepository.author = author
            }

            return modifiedRepository
        }
        .catch { _ in Just<GithubRepository>(repository) }
        .eraseToAnyPublisher()
    }
}
