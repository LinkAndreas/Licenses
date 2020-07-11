//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ListView(height: .constant(geometry.size.height))
            }
            .frame(minWidth: 400, maxWidth: 550)
            RepositoryDetail()
        }
        .listStyle(SidebarListStyle())
    }
}
