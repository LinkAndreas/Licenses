//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct SupportedManifestsView: View {
    @ObservedObject var store: ViewStore<SupportedManifestsViewState, Never>

    var body: some View {
        VStack {
            Text(L10n.Onboarding.SupportedManifests.description)
            Spacer()
                .frame(height: 16)
            VStack(alignment: .leading, spacing: 8) {
                ForEach(store.entries) { entry in
                    Label(entry.description, systemImage: entry.imageSystemName)
                }
            }
        }
    }
}

struct SupportedManifestsView_Previews: PreviewProvider {
    static var previews: some View {
        SupportedManifestsView(store: .constant(state: PreviewData.Onboarding.supportedManifests))
    }
}
