//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

class GithubRepository: Identifiable {
    let packageManager: PackageManager
    var name: String
    let version: String
    var id: UUID

    var author: String?
    var url: URL?
    var license: GithubLicense?

    var isProcessing: Bool

    init(
        packageManager: PackageManager,
        name: String,
        version: String,
        author: String? = nil,
        url: URL? = nil,
        license: GithubLicense? = nil,
        isProcessing: Bool = false
    ) {
        self.id = .init()
        self.packageManager = packageManager
        self.name = name
        self.version = version
        self.author = author
        self.url = url
        self.license = license
        self.isProcessing = isProcessing
    }
}

extension GithubRepository: Comparable {
    static func < (lhs: GithubRepository, rhs: GithubRepository) -> Bool {
        return lhs.name < rhs.name
    }
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
        result += ["\(packageManager.rawValue)"]
        result += ["\(id)"]
        author.map { result += ["\($0)"] }
        url.map { result += ["\($0.absoluteString)"] }
        return result.joined(separator: " | ")
    }
}
