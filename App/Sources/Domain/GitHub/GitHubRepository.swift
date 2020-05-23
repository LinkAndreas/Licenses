//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct GitHubRepository: Repository, Identifiable {
    var id: String { return url.absoluteString }

    let author: String
    let name: String
    let url: URL

    init (
        author: String,
        name: String
    ) {
        self.author = author
        self.name = name
        self.url = URL(string: "https://github.com/\(author)/\(name)")!
    }
}

extension GitHubRepository: Hashable { /* Protocol Conformance */ }

extension GitHubRepository: CustomStringConvertible {
    var description: String {
        return "\(author)/\(name): \(url)"
    }
}
