//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine
import SwiftUI

struct ProgressBar: View {
    @Binding var value: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .opacity(0.3)
                    .foregroundColor(.gray)

                Rectangle()
                    .frame(
                        width: min(
                            CGFloat(self.value) * geometry.size.width,
                            geometry.size.width
                        ),
                        height: geometry.size.height
                    )
                    .foregroundColor(.blue)
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: .constant(0.36))
            .frame(width: 300, height: 20)
    }
}
