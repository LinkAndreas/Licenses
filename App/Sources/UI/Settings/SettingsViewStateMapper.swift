//  Copyright © 2021 Andreas Link. All rights reserved.

enum SettingsViewStateMapper {
    static func map(state: SettingsState) -> SettingsViewState {
        return .init(
            checkBoxDescription: L10n.Settings.Tabs.General.AutomaticLicenseSearch.title,
            isCheckBoxChecked: state.isAutomaticFetchEnabled,
            tokenText: state.token,
            tokenPlaceholder: L10n.Settings.Tabs.Token.placeholder,
            tokenDescription: L10n.Settings.Tabs.Token.description,
            generalTab: .init(
                title: L10n.Settings.Tabs.General.title,
                imageSystemName: "gear",
                tag: .general
            ),
            tokenTab: .init(
                title: L10n.Settings.Tabs.Token.title,
                imageSystemName: "tag",
                tag: .token
            )
        )
    }
}
