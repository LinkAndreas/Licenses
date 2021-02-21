//  Copyright © 2021 Andreas Link. All rights reserved.

enum DetailViewActionMapper {
    static func map(action: DetailViewAction) -> AppAction {
        switch action {
        case let .placeholder(action: .didChooseManifests(filePaths)):
            return .searchManifests(filePaths: filePaths)

        case .placeholder(action: .didChooseExampleManifests):
            return .useExampleManifests
        }
    }
}
