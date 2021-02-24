//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct FileDropAreaViewState: Equatable {
    let isTargeted: Bool
    let supportedFileTypes: [String]
    let borderColor: Color
}
