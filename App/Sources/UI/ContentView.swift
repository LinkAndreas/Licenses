//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import SwiftUI

struct ContentView: View {
    @State private var isTargeted: Bool = false
    let collector: ArtfictCollector = .init()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Color
                .white
                .frame(width: 100, height: 100)
                .onDrop(of: ["public.file-url"], isTargeted: self.$isTargeted) { providers -> Bool in
                    providers.first?.loadDataRepresentation(
                        forTypeIdentifier: "public.file-url",
                        completionHandler: { data, _ in
                            guard
                                let data = data,
                                let path = NSString(data: data, encoding: 4),
                                let url = URL(string: path as String)
                            else { return }

                            self.collector.search(at: url) { artifacts in
                                print(GitHubRepositoryDecoder.decodeRepositories(from: artifacts))
                            }
                        }
                    )
                    return true
                }
                .border(self.isTargeted ? Color.red : Color.clear)
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
