//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    ListView()
                    store.progress.map {
                        ProgressBar(value: .constant($0))
                        .frame(height: 5)
                        .padding([.leading, .trailing, .bottom], 16)
                    }
                }
                .frame(width: 400)
                RepositoryDetail()
            }
            .listStyle(SidebarListStyle())
        }
    }
}
