//  Copyright © 2021 Andreas Link. All rights reserved.

enum MasterViewActionMapper {
    static func map(action: MasterViewAction) -> AppAction {
        switch action {
        case let .repositoryList(action: .didSelectRepository(selection)):
            return .selectedRepository(id: selection)
        }
    }
}
