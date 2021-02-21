//  Copyright © 2021 Andreas Link. All rights reserved.

import Foundation

enum ToolbarItemsAction {
    case didChooseManifests([URL])
    case didChooseExportDestination(URL)
    case didTriggerRefresh
}
