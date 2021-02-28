//  Copyright © 2021 Andreas Link. All rights reserved.

final class SettingsEnvironment {
    var settingsDataSource: SettingsSynchronousDataSource

    init(settingsDataSource: SettingsSynchronousDataSource = Defaults.shared) {
        self.settingsDataSource = settingsDataSource
    }
}
