//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct Icon: View {
    let name: String
    let size: CGSize

    init(name: String, size: CGSize = .init(width: 40, height: 40)) {
        self.name = name
        self.size = size
    }

    var body: some View {
        Image(name)
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.accentColor)
            .frame(width: size.width, height: size.height)
    }
}

struct Icon_Previews: PreviewProvider {
    static var previews: some View {
        Icon(name: "version")
    }
}
