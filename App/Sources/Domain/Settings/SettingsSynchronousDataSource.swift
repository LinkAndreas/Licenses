//  Copyright © 2021 Andreas Link. All rights reserved.

protocol SettingsSynchronousDataSource {
    var token: String { get set }
    var isAutomaticFetchEnabled: Bool { get set }
}
