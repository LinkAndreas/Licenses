//  Copyright © 2021 Andreas Link. All rights reserved.

struct SettingsViewState: Equatable {
    let checkBoxDescription: String
    let isCheckBoxChecked: Bool
    let tokenText: String
    let tokenPlaceholder: String
    let tokenDescription: String
    let generalTab: SettingsTab
    let tokenTab: SettingsTab
}

struct SettingsTab: Equatable {
    let title: String
    let imageSystemName: String
    let tag: SettingsTag
}

enum SettingsTag: Hashable {
    case general
    case token
}
