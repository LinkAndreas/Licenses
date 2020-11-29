//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct DetailPlaceholderView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack(spacing: 16) {
                Image(systemName: "cube.box")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 60))
                Text(L10n.Detail.placeholder)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
            }
            Spacer()
        }
    }
}

struct DetailPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPlaceholderView()
    }
}
