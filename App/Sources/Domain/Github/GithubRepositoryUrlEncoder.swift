//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

enum GithubRepositoryUrlEncoder {
    static func encode(name: String, author: String) -> URL {
        return URL(string: "https://github.com/\(author)/\(name)")!
    }
}
