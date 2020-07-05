//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct GithubRequestLimitView: View {
    @EnvironmentObject var store: GlobalStore

    var body: some View {
        Group {
            if let githubRequestStatus = store.githubRequestStatus {
                Group {
                    if githubRequestStatus.remaining == 0 {
                        Text("Github Request limit exceeded. Please add a personal access token in settings.")
                            .foregroundColor(.red)
                    }
                }
                .padding([.top], 2)
                .padding([.leading, .bottom, .trailing], 8)
            }
        }
    }
}

struct GithubRequestLimitView_Previews: PreviewProvider {
    static var previews: some View {
        GithubRequestLimitView()
            .environmentObject(
                LocalStore(
                    isTargeted: false,
                    repositories: [],
                    progress: 0.5
                )
            )
            .environmentObject(
                GlobalStore(
                    githubRequestStatus: .init(
                        limit: 40,
                        remaining: 0,
                        resetInterval: 30
                    )
                )
            )
            .previewLayout(.fixed(width: 650, height: 500))
    }
}
