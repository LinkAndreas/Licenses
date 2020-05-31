//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct GitHubRepository {
    let packageManager: PackageManager
    var name: String { didSet { updateUrlIfNeeded() } }
    var version: String

    var author: String? { didSet { updateUrlIfNeeded() } }
    var url: URL?
    var license: GitHubLicense?

    init(packageManager: PackageManager, name: String, version: String, author: String? = nil) {
        self.packageManager = packageManager
        self.name = name
        self.version = version
        self.author = author
        self.updateUrlIfNeeded()
    }

    private mutating func updateUrlIfNeeded() {
        guard let author = author else { return self.url = nil }

        self.url = URL(string: "https://github.com/\(author)/\(name)")
    }
}

extension GitHubRepository: Identifiable {
    var id: String { "\(name)_\(version)_\(author ?? "unkown")" }
}

extension GitHubRepository: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension GitHubRepository: Equatable {
    static func == (lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
        return lhs.id == rhs.id
    }
}

extension GitHubRepository: CustomStringConvertible {
    var description: String {
        var result: [String] = []
        result += ["\(name)"]
        result += ["\(version)"]
        author.map { result += ["\($0)"] }
        url.map { result += ["\($0.absoluteString)"] }
        return result.joined(separator: ", ")
    }
}
