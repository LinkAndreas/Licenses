//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryMaster: View {
    var body: some View {
        VStack(spacing: 0) {
            ListView()
            InformationView()
        }
        .frame(width: 400)
    }
}

struct RepositoryMaster_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryMaster()
    }
}
