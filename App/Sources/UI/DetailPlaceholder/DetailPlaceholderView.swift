//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct DetailPlaceholderView: View {
    @ObservedObject var store: ViewStore<DetailPlaceholderViewState, DetailPlaceholderViewAction>

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack(spacing: 0) {
                VStack(spacing: 32) {
                    ForEach(store.entries) { entry in
                        DetailPlaceholderEntryView(entry: entry)
                        .offset(x: entry.offset)
                    }
                }
                Spacer()
                    .frame(height: 48)

                VStack(spacing: 16) {
                    Text(store.title)
                        .font(.title)
                        .foregroundColor(Color(NSColor.labelColor))
                        .fontWeight(.bold)

                    Text(store.subtitle)
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
                            FileImporter.openFiles { filePaths in
                                store.send(.didChooseManifests(filePaths: filePaths))
                            }
                        },
                        label: {
                            Text(store.primaryButtonTitle)
                                .fontWeight(.semibold)
                        }
                    )
                    .buttonStyle(BrandedButtonStyle())
                    .disabled(store.isPrimaryButtonDisabled)

                    Button(
                        action: { store.send(.didChooseExampleManifests) },
                        label: {
                            Text(store.secondaryButtonTitle)
                                .font(.caption)
                        }
                    )
                    .buttonStyle(BrandedLinkButtonStyle())
                    .disabled(store.isSecondaryButtonDisabled)
                }
            }
            .foregroundColor(Color(Asset.Colors.light.color))
            Spacer()
        }
    }
}

struct DetailPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPlaceholderView(
            store: .constant(state: PreviewData.DetailPlaceholder.state)
        )
        .previewLayout(.sizeThatFits)
    }
}
