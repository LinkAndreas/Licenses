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
                            providers.first?.loadDataRepresentation(
                                forTypeIdentifier: "public.file-url",
                                completionHandler: { data, _ in
                                    guard
                                        let data = data,
                                        let path = NSString(data: data, encoding: 4),
                                        let url = URL(string: path as String)
                                    else { return }

                                    DispatchQueue.main.async {
                                        self.store.searchManifests(at: url)
                                    }
                                }
                            )
                            return true
                        }
                    .border(self.store.isTargeted ? Color.red : Color.clear)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
