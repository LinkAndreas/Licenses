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
                    if let progress = store.progress {
                        ProgressBar(value: .constant(progress))
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
