//  Copyright © 2020 Andreas Link. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct SplitView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        VStack {
            NavigationView {
                RepositoryMaster(store: store)
                RepositoryDetail(store: store)
            }
            .listStyle(SidebarListStyle())
        }
    }
}
