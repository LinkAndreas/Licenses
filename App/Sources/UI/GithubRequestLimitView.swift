//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct GithubRequestLimitView: View {
    @EnvironmentObject var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        ViewStoreProvider(self.store) { viewStore in
            if viewStore.githubRequestStatus != nil && viewStore.githubRequestStatus!.remaining == 0 {
                Text("Github Request limit exceeded. Please add a personal access token in settings.")
                    .foregroundColor(.red)
                    .padding([.top], 2)
                    .padding([.leading, .bottom, .trailing], 8)
            }
        }
    }
}
