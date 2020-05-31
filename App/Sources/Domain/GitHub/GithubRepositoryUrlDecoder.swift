//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum GitHubRepositoryUrlDecoder {
    static func decode(repositoryUrlString: String) -> (name: String, author: String)? {
        guard let url = URL(string: repositoryUrlString) else { return nil }

        return decode(repositoryURL: url)
    }

    static func decode(repositoryURL: URL) -> (name: String, author: String)? {
        let urlComponents: [String] = makeUrlComponents(from: repositoryURL.absoluteString)

        guard
            let name = extractName(from: urlComponents),
            let author = extractAuthor(from: urlComponents)
        else { return nil }

        return (name, author)
    }
}

extension GitHubRepositoryUrlDecoder {
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

    private static func makeUrlComponents(from urlString: String) -> [String] {
        return urlString
            .replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "http://", with: "")
            .components(separatedBy: "/")
    }
}
