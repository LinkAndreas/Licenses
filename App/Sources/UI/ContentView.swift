//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            RepositoryList()
                .frame(minWidth: 350)
            RepositoryDetail()
        }.listStyle(SidebarListStyle())
    }
}
