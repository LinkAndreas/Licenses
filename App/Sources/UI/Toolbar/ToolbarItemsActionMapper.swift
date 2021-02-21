//  Copyright © 2021 Andreas Link. All rights reserved.

enum ToolbarItemsActionMapper {
    static func map(action: ToolbarItemsAction) -> AppAction {
        switch action {
        case let .didChooseExportDestination(filePath):
            return .exportLicenses(destination: filePath)

        case let .didChooseManifests(filePaths):
            return .searchManifests(filePaths: filePaths)

        case .didTriggerRefresh:
            return .fetchLicenses
        }
    }
}
