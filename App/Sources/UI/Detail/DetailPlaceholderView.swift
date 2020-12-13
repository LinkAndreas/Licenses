//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct DetailPlaceholderView: View {
    @EnvironmentObject private var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        VStack(alignment: .center) {
            Spacer()

            VStack {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "cube.box")
                        .font(.system(size: 60))

                    Text(L10n.Detail.placeholder)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 300)

                    VStack(alignment: .center, spacing: 16) {
                        VStack(alignment: .leading) {
                            Text(L10n.Detail.Placeholder.SupportedManifests.SwiftPm.title)
                            Text(L10n.Detail.Placeholder.SupportedManifests.Carthage.title)
                            Text(L10n.Detail.Placeholder.SupportedManifests.Cocoapods.title)
                        }
                    }
                }

                VStack(spacing: 16) {
                    Text(L10n.Detail.Placeholder.Examples.title)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 300)
                    Button(L10n.Detail.Placeholder.Examples.Button.title) {
                        guard
                            let url = Bundle.main.url(forResource: "Cartfile", withExtension: "resolved")
                        else { return }

                        store.send(.searchManifests(filePaths: [url]))
                    }
                    .buttonStyle(BrandedButtonStyle())
                    .disabled(store.state.isProcessing)
                }

                Spacer()
            }
            .foregroundColor(Color(Asset.Colors.light.color))

            Spacer()
        }
    }
}

struct DetailPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPlaceholderView()
    }
}
