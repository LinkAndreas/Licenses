//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct InformationView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        Group {
            if store.progress != nil || store.errorMessage != nil {
                VStack {
                    ProgressView()
                    ErrorMessageView()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
