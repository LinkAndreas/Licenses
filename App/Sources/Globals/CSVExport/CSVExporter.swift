//  Copyright © 2020 Andreas Link. All rights reserved.

import Foundation

enum CSVExporterError: Error {
    case columnMismatch
}

enum CSVExporter {
    static func exportCSV(fromRows rows: [[String]], toDestination destination: URL) {
        do {
            let csvString: String = try makeCSV(fromRows: rows)
            try csvString.write(to: destination, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }

    private static func makeCSV(fromRows rows: [[String]]) throws -> String {
        var numberOfColumnsInHeader: Int?
        return try (0 ... (rows.count - 1)).reduce("") { csv, index in
            let nextRow: [String] = rows[index]

            if index == 0 {
                numberOfColumnsInHeader = nextRow.count
            } else {
                guard
                    let numberOfColumnsInHeader = numberOfColumnsInHeader,
                    nextRow.count == numberOfColumnsInHeader
                else {
                    throw CSVExporterError.columnMismatch
                }
            }

            return csv + (index > 0 ? "\n" : "") + "\(nextRow.joined(separator: ","))"
        }
    }
}
