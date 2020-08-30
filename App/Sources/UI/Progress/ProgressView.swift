//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        store.progress.map {
            ProgressBar(value: .constant($0))
                .frame(height: 5)
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(
                Store(
                    isTargeted: false,
                    progress: 0.5,
                    errorMessage: "Test error message",
                    repositories: []
                )
            )
            .previewLayout(.fixed(width: 650, height: 500))
    }
}
