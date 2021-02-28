//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct ProgressView: View {
    @ObservedObject var store: ViewStore<ProgressViewState, Never>

    var body: some View {
        store.progress.map {
            ProgressBar(value: .constant($0))
                .frame(height: 5)
        }
    }
}

struct Progress_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(store: .constant(state: PreviewData.Progress.state))
            .previewLayout(.fixed(width: 650, height: 500))
    }
}
