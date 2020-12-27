//  Copyright © 2021 Andreas Link. All rights reserved.

enum Defaults {
    @Storage(key: "token", defaultValue: "") static var token: String
    @Storage(key: "isAutomaticFetchEnabled", defaultValue: true) static var isAutomaticFetchEnabled: Bool
    @Storage(key: "isOnboardingCompleted", defaultValue: false) static var isOnboardingCompleted: Bool
}
