//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct SplitView: View {
    var body: some View {
        VStack {
            NavigationView {
                MasterView()
                DetailView()
            }
            .listStyle(SidebarListStyle())
        }
    }
}
