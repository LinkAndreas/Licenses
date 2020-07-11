//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: LocalStore
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ListView(height: .constant(geometry.size.height))
            }
            .frame(minWidth: 300, maxWidth: 450)
            RepositoryDetail()
        }
        .listStyle(SidebarListStyle())
    }
}
