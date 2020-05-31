//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum GitHubRepositoryFactory {
    static func make(from name: String?, and author: String?) -> GitHubRepository? {
        guard let name = name, let author = author else { return nil }

        return .init(name: name, author: author)
    }

    static func make(from url: URL?) -> GitHubRepository? {
        guard
            let url = url,
            url.absoluteString.contains("github.com"),
            let (name, author) = GitHubRepositoryUrlDecoder.decode(repositoryURL: url)
        else { return nil }

        return GitHubRepository(name: name, author: author)
    }

    static func make(fromURLString urlString: String?) -> GitHubRepository? {
        guard let urlString = urlString, let url = URL(string: urlString) else { return nil }

        return make(from: url)
    }
}
