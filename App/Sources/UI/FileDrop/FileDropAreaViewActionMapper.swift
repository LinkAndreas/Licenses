//  Copyright © 2021 Andreas Link. All rights reserved.

enum FileDropAreaViewActionMapper {
    static func map(action: FileDropAreaViewAction) -> AppAction {
        switch action {
        case let .didSelectProviders(providers):
            return .handle(providers: providers)

        case let .didUpdateIsTargeted(isTargeted):
            return .updateIsTargeted(value: isTargeted)
        }
    }
}
