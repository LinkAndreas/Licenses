//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct GithubRepository {
    let packageManager: PackageManager
    var name: String
    var version: String

    var author: String?
    var url: URL?
    var license: GithubLicense?

    init(
        packageManager: PackageManager,
        name: String,
        version: String,
        author: String? = nil,
        url: URL? = nil
    ) {
        self.packageManager = packageManager
        self.name = name
        self.version = version
        self.author = author
        self.url = url
    }
}

extension GithubRepository: Identifiable {
    var id: String { "\(name)_\(version)" }
}

extension GithubRepository: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension GithubRepository: Equatable {
    static func == (lhs: GithubRepository, rhs: GithubRepository) -> Bool {
        return lhs.id == rhs.id
    }
}

extension GithubRepository: CustomStringConvertible {
    var description: String {
        var result: [String] = []
        result += ["\(name)"]
        result += ["\(version)"]
        author.map { result += ["\($0)"] }
        url.map { result += ["\($0.absoluteString)"] }
        return result.joined(separator: ", ")
    }
}
