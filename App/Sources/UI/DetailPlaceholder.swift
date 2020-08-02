//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct DetailPlaceholder: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack {
                Icon(name: "box", size: .init(width: 100, height: 100))
                Text(L10n.Detail.placeholder)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
            }
            Spacer()
        }
    }
}

struct DetailPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        DetailPlaceholder()
    }
}
