//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

enum FileDropAreaViewAction {
    case didSelectProviders([NSItemProvider])
    case didUpdateIsTargeted(Bool)
}
