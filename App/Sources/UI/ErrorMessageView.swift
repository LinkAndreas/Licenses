//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct ErrorMessageView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        Group {
            store.errorMessage.map { errorMessage in
                Group {
                    Text(errorMessage)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct GithubRequestLimitView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView()
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
