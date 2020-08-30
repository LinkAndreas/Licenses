//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct SplitView: View {
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
