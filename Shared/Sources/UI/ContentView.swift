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
            RepositoryDetail()
        }
        .listStyle(SidebarListStyle())
//        .toolbar {
//            ToolbarItem {
//                Button(
//                    action: store.fetchLicenses,
//                    label: {
//                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
//                    }
//                )
//            }
//            ToolbarItem {
//                Button(
//                    action: store.deleteAll,
//                    label: {
//                        Image(systemName: "square.and.arrow.up")
//                    }
//                )
//            }
//        }
    }
}
