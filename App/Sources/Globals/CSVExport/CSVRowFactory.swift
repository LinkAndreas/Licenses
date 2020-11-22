//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum CSVRowFactory {
    static func makeRows(from repositories: [GithubRepository]) -> [[String]] {
        [makeHeaderRow()] + repositories.map(makeRow(from:))
    }
}

extension CSVRowFactory {
    private static func makeHeaderRow() -> [String] {
        [
            L10n.Csv.Header.Name.title,
            L10n.Csv.Header.Version.title,
            L10n.Csv.Header.PackageManager.title,
            L10n.Csv.Header.Author.title,
            L10n.Csv.Header.LicenseUrl.title,
            L10n.Csv.Header.LicenseName.title,
            L10n.Csv.Header.LicenseContent.title
        ]
    }

    private static func makeRow(from repository: GithubRepository) -> [String] {
        normalize(
            row: [
                repository.name,
                repository.version,
                repository.packageManager.rawValue,
                repository.author ?? "",
                repository.license?.downloadURL ?? "",
                repository.license?.license?.name ?? "",
                repository.license?.decodedContent ?? ""
            ]
        )
    }

    private static func normalize(row: [String]) -> [String] {
        row.map { string in
            guard string.contains("\"") || string.contains(",") else { return string }

            let doubleQuotesEscapedString: String = string.replacingOccurrences(of: "\"", with: "\"\"")
            return "\("\"")\(doubleQuotesEscapedString)\("\"")"
        }
    }
}
