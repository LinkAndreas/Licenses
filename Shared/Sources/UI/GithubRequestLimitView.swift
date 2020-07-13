//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct GithubRequestLimitView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        Group {
            store.githubRequestStatus.map { status in
                Group {
                    if status.remaining == 0 {
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
                Store(
                    isTargeted: false,
                    progress: 0.5,
                    githubRequestStatus: .init(
                        limit: 40,
                        remaining: 0,
                        resetInterval: 30
                    ),
                    repositories: []
                )
            )
            .previewLayout(.fixed(width: 650, height: 500))
    }
}
