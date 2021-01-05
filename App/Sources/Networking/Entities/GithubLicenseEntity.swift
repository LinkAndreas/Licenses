//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

struct GithubLicenseEntity: Codable {
    var name: String?
    var path: String?
    var sha: String?
    var size: Int?
    var url: String?
    var htmlURL: String?
    var gitURL: String?
    var downloadURL: String?
    var type: String?
    var content: String?
    var encoding: String?
    var links: LinksEntity?
    var license: LicenseEntity?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case path = "path"
        case sha = "sha"
        case size = "size"
        case url = "url"
        case htmlURL = "html_url"
        case gitURL = "git_url"
        case downloadURL = "download_url"
        case type = "type"
        case content = "content"
        case encoding = "encoding"
        case links = "_links"
        case license = "license"
    }
}
