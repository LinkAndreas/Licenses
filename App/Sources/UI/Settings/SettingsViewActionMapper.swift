//  Copyright © 2021 Andreas Link. All rights reserved.

enum SettingsViewActionMapper {
    static func map(action: SettingsViewAction) -> SettingsAction {
        switch action {
        case let .didUpdateCheckBox(value):
            return .didChangeIsAutomaticFetchEnabled(value)

        case let .didUpdateToken(value):
            return .didChangeToken(value)
        }
    }
}
