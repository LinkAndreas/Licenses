//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct ToolbarContent: View {
    @EnvironmentObject var store: Store

    enum Constants {
        static let fetchIconName: String = "icnFetch"
        static let shareIconName: String = "icnShare"
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 16) {
                IconButton(
                    iconName: Constants.fetchIconName,
                    isDisabled: self.store.isProcessing,
                    action: self.store.fetchLicenses
                )
                IconButton(
                    iconName: Constants.shareIconName,
                    isDisabled: self.store.isProcessing,
                    action: self.store.exportLicenses
                )
            }
            .padding()
            .offset(y: -geometry.size.height / 2)
        }
    }
}

struct ToolbarContent_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarContent()
    }
}
