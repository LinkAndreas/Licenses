//  Copyright © 2020 Andreas Link. All rights reserved.

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        NavigationView {
            RepositoryList(store: self.store)
                .frame(minWidth: 350)
            RepositoryDetail(store: self.store)
        }.listStyle(SidebarListStyle())
    }
}
