//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationView {
                RepositoryMaster()
                RepositoryDetail()
            }
            .listStyle(SidebarListStyle())
        }
    }
}
