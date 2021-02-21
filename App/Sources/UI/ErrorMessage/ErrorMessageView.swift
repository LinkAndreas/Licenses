//  Copyright © 2021 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct ErrorMessageView: View {
    @ObservedObject var store: ViewStore<ErrorMessageViewState, Never>

    var body: some View {
        Text(store.message)
            .multilineTextAlignment(.leading)
            .foregroundColor(.red)
    }
}

struct GithubRequestLimitView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView(store: .constant(state: PreviewData.ErrorMessage.state))
            .previewLayout(.sizeThatFits)
    }
}
