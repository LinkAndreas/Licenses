//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct FileDropArea<Content: View>: View {
    @EnvironmentObject var store: Store

    private var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            Group {
                VStack {
                    self.content()
                        .onDrop(
                            of: ["public.file-url"],
                            isTargeted: self.$store.isTargeted
                        ) { providers -> Bool in
                            self.store.handle(itemProviders: providers)
                            return true
                        }
                    .border(self.store.isTargeted ? Color.red : Color.clear)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
