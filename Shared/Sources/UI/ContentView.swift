//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: LocalStore
    
    var body: some View {
        NavigationView {
            RepositoryList()
                .frame(minWidth: 350)
            RepositoryDetail()
        }
        .toolbar {
            ToolbarItem {
                Button("Fetch Licenses", action: store.fetchLicenses)
            }
        }
        .listStyle(SidebarListStyle())
    }
}
