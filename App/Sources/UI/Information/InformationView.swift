//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct InformationView: View {
    @ObservedObject var store: ViewStore<InformationViewState, Never>

    var body: some View {
        VStack {
            ViewStoreWithNonOptionalStateProvider(
                from: store.derived(stateMapper: \.progressState).withoutActions,
                success: ProgressView.init(store:)
            )

            ViewStoreWithNonOptionalStateProvider(
                from: store.derived(stateMapper: \.errorMessageState).withoutActions,
                success: ErrorMessageView.init(store:)
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(
            store: .constant(
                state: .init(
                    progressState: PreviewData.Progress.state,
                    errorMessageState: PreviewData.ErrorMessage.state
                )
            )
        )

        InformationView(
            store: .constant(
                state: .init(
                    progressState: PreviewData.Progress.state,
                    errorMessageState: nil
                )
            )
        )

        InformationView(
            store: .constant(
                state: .init(
                    progressState: nil,
                    errorMessageState: PreviewData.ErrorMessage.state
                )
            )
        )
    }
}
