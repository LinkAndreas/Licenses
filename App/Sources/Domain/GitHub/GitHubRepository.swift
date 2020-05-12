//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct GitHubRepository: Repository {
    let author: String
    let name: String
    let url: URL

    init? (
        author: String,
        name: String
    ) {
        guard let url = URL(string: "https://github.com/\(author)/\(name)")  else { return nil }

        self.author = author
        self.name = name
        self.url = url
    }
}

extension GitHubRepository: Hashable { /* Protocol Conformance */ }

extension GitHubRepository: CustomStringConvertible {
    var description: String {
        return "\(author)/\(name): \(url)"
    }
}
