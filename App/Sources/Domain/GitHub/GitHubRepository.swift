//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct GitHubRepository: Repository, Identifiable {
    var id: String { url.absoluteString }

    let name: String
    let author: String
    let url: URL
    var license: GitHubLicense?

    init(name: String, author: String) {
        self.name = name
        self.author = author
        self.url = URL(string: "https://github.com/\(author)/\(name)")!
    }
}

extension GitHubRepository: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
}

extension GitHubRepository: Equatable {
    static func == (lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
        return lhs.url == rhs.url
    }
}

extension GitHubRepository: CustomStringConvertible {
    var description: String {
        return "\(author)/\(name): \(url)"
    }
}
