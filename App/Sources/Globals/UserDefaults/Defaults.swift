//  Copyright © 2021 Andreas Link. All rights reserved.

struct Defaults: SettingsSynchronousDataSource {
    static let shared: Self = .init()

    @Storage(key: "token", defaultValue: "") var token: String
    @Storage(key: "isAutomaticFetchEnabled", defaultValue: true) var isAutomaticFetchEnabled: Bool
    @Storage(key: "isOnboardingCompleted", defaultValue: false) var isOnboardingCompleted: Bool
}
