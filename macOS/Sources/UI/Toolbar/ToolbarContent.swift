//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct ToolbarContent: View {
    @EnvironmentObject var store: Store

    enum Constants {
        static let fetchIconName: String = "icnFetch"
        static let shareIconName: String = "icnShare"
    }

    var body: some View {
        HStack(spacing: 16) {
            IconButton(
                iconName: Constants.fetchIconName,
                isDisabled: store.isProcessing,
                action: store.fetchLicenses
            )
            IconButton(
                iconName: Constants.shareIconName,
                isDisabled: store.isProcessing,
                action: store.exportLicenses
            )
        }.padding()
    }
}

struct ToolbarContent_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarContent()
    }
}
