//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

struct PodSpecEntity: Codable {
    let name: String
    let version: String
    let license: String
    let summary: String
    let homepage: String
    let authors: [String]
    let source: SourceEntity
}

extension PodSpecEntity {
    enum CodingKeys: String, CodingKey {
        case name
        case version
        case license
        case summary
        case homepage
        case authors
        case source
    }
}

struct SourceEntity: Codable {
    let git: String
    let tag: String
}

extension SourceEntity {
    enum CodingKeys: String, CodingKey {
        case git
        case tag
    }
}
