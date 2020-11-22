//  Copyright © 2020 Andreas Link. All rights reserved.

enum Defaults {
    @Storage(key: "token", defaultValue: "") static var token: String
    @Storage(key: "isAutomaticFetchEnabled", defaultValue: false) static var isAutomaticFetchEnabled: Bool
}
