//  Copyright © 2021 Andreas Link. All rights reserved.

import SwiftUI

struct SettingsView: View {
    @ObservedObject var store: ViewStore<SettingsViewState, SettingsViewAction>

    var body: some View {
        TabView {
            Form {
                VStack(alignment: .leading, spacing: 16) {
                    Toggle(
                        store.checkBoxDescription,
                        isOn: store.binding(
                            get: \.isCheckBoxChecked,
                            send: { isCheckBoxChecked in .didUpdateCheckBox(isCheckBoxChecked) }
                        )
                    )
                }
            }.tabItem {
                Label(store.generalTab.title, systemImage: store.generalTab.imageSystemName)
            }
            .tag(store.generalTab.tag)
            Form {
                VStack(alignment: .leading, spacing: 16) {
                    TextField(
                        store.tokenPlaceholder,
                        text: store.binding(
                            get: \.tokenText,
                            send: { tokenText in .didUpdateToken(tokenText) }
                        )
                    )
                    Text(store.tokenDescription)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }.tabItem {
                Label(store.tokenTab.title, systemImage: store.tokenTab.imageSystemName)
            }
            .tag(store.tokenTab.tag)
        }
        .padding(20)
        .frame(minWidth: 500, maxWidth: 500)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            store: .constant(
                state: PreviewData.Settings.state
            )
        )
    }
}
