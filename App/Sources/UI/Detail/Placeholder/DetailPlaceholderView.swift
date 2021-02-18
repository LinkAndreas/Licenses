//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct DetailPlaceholderView: View {
    @EnvironmentObject private var store: Store<AppState, AppAction, AppEnvironment>

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack(spacing: 0) {
                VStack(spacing: 32) {
                    DetailPlaceholderEntryView(
                        title: "xxxxxxxxxxxxxx",
                        subtitle: "xxxxxxxxxx",
                        caption: "xxxxxxxxxxxxxxx"
                    )
                    .offset(x: 40)
                    DetailPlaceholderEntryView(
                        title: "xxxxxxxxxxxxxxx",
                        subtitle: "xxxxxx",
                        caption: "xxxxxxxxx"
                    )
                    .offset(x: -30)
                    DetailPlaceholderEntryView(
                        title: "xxxx",
                        subtitle: "xxxxxxxxxxxx",
                        caption: "xxxxxxxxxxxxxxxxxxx"
                    )
                    .offset(x: 90)
                }
                Spacer()
                    .frame(height: 48)

                VStack(spacing: 16) {
                    Text(L10n.Detail.Placeholder.title)
                        .font(.title)
                        .foregroundColor(Color(NSColor.labelColor))
                        .fontWeight(.bold)

                    Text(L10n.Detail.Placeholder.subtitle)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(NSColor.secondaryLabelColor))
                        .frame(maxWidth: 500)
                }

                Spacer()
                    .frame(height: 48)

                VStack(spacing: 16) {
                    Button(
                        action: {
                            FileImporter.openFiles { urls in
                                store.send(.searchManifests(filePaths: urls))
                            }
                        },
                        label: {
                            Text(L10n.Detail.Placeholder.Button.ChooseManifests.title)
                                .fontWeight(.semibold)
                        }
                    )
                    .buttonStyle(BrandedButtonStyle())
                    .disabled(store.state.isProcessing)

                    Button(
                        action: {
                            guard
                                let swiftPmUrl = Bundle.main.url(forResource: "Package", withExtension: "resolved"),
                                let cartfileUrl = Bundle.main.url(forResource: "Cartfile", withExtension: "resolved"),
                                let cocoapodsUrl = Bundle.main.url(forResource: "Podfile", withExtension: "lock")
                            else { return }

                            store.send(.searchManifests(filePaths: [swiftPmUrl, cartfileUrl, cocoapodsUrl]))
                        },
                        label: {
                            Text(L10n.Detail.Placeholder.Button.ExampleManifest.title)
                                .font(.caption)
                        }
                    )
                    .buttonStyle(BrandedLinkButtonStyle())
                    .disabled(store.state.isProcessing)
                }
            }
            .foregroundColor(Color(Asset.Colors.light.color))
            Spacer()
        }
    }
}

struct DetailPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPlaceholderView()
            .environmentObject(
                Store<AppState, AppAction, AppEnvironment>(
                    initialState: .init(
                        isProcessing: false,
                        isTargeted: false,
                        progress: 0.75,
                        remainingRepositories: 0,
                        totalRepositories: 0,
                        errorMessage: nil,
                        selection: nil,
                        repositories: []
                    ),
                    reducer: appReducer,
                    environment: DefaultEnvironment()
                )
            )
            .previewLayout(.sizeThatFits)
    }
}
