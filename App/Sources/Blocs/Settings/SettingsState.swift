//  Copyright © 2021 Andreas Link. All rights reserved.

struct SettingsState: Equatable {
    static let initial: Self = .init()

    var isAutomaticFetchEnabled: Bool
    var token: String

    init(
        settingsDataSource: SettingsSynchronousDataSource = Defaults.shared
    ) {
        self.isAutomaticFetchEnabled = settingsDataSource.isAutomaticFetchEnabled
        self.token = settingsDataSource.token
    }
}
