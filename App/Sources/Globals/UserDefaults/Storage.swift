//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

@propertyWrapper
struct Storage<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get { UserDefaults.standard.value(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}
