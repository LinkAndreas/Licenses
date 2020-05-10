//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum GitHubRepositoryFactory {
    static func makeRepository(from url: URL?) -> GitHubRepository? {
        guard let url = url else { return nil }

        return makeRepository(from: url.absoluteString)
    }

    static func makeRepository(from urlString: String?) -> GitHubRepository? {
        guard let urlString: String = urlString, urlString.contains("github.com") else { return nil }

        let urlComponents: [String] = makeUrlComponents(from: urlString)

        guard
            let name: String = extractName(from: urlComponents),
            let author: String = extractAuthor(from: urlComponents)
        else {
            return nil
        }

        return GitHubRepository(author: author, name: name)
    }
}

extension GitHubRepositoryFactory {
    private static func makeUrlComponents(from urlString: String) -> [String] {
        return urlString
            .replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "http://", with: "")
            .components(separatedBy: "/")
    }

    private static func extractName(from urlComponents: [String]) -> String? {
        return urlComponents.last?.removing(suffix: ".git")
    }

    private static func extractAuthor(from urlComponents: [String]) -> String? {
        if urlComponents.count >= 3 {
            return urlComponents[urlComponents.count - 2]
        } else {
            return urlComponents.first?.components(separatedBy: ":").last
        }
    }
}
