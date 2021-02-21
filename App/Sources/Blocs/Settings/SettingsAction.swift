//  Copyright © 2021 Andreas Link. All rights reserved.

enum SettingsAction {
    case readIsAutomaticFetchEnabled
    case readToken
    case didChangeIsAutomaticFetchEnabled(Bool)
    case didChangeToken(String)
}
