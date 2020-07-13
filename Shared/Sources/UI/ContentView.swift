//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack{
            NavigationView {
                VStack {
                    GeometryReader { geometry in
                        ListView(height: .constant(geometry.size.height))
                    }
                    store.progress.map {
                        ProgressBar(value: .constant($0))
                        .frame(height: 5)
                        .padding([.leading, .trailing, .bottom], 16)
                    }
                }
                .frame(minWidth: 400, maxWidth: 550)
                RepositoryDetail()
            }
            .listStyle(SidebarListStyle())
        }
    }
}
