//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general
        case token
    }

    @AppStorage("token") private var token: String = ""
    @AppStorage("isAutomaticFetchEnabled") private var isAutomaticFetchEnabled: Bool = false

    var body: some View {
        TabView {
            Form {
                VStack(alignment: .leading, spacing: 16) {
                    Toggle(
                        L10n.Settings.Tabs.General.AutomaticLicenseSearch.title,
                        isOn: $isAutomaticFetchEnabled
                    )
                }
            }.tabItem {
                Label(L10n.Settings.Tabs.General.title, systemImage: "gear")
            }
            .tag(Tabs.general)
            Form {
                VStack(alignment: .leading, spacing: 16) {
                    TextField(
                        L10n.Settings.Tabs.Token.placeholder,
                        text: $token
                    )
                    Text(L10n.Settings.Tabs.Token.description)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }.tabItem {
                Label(L10n.Settings.Tabs.Token.title, systemImage: "tag")
            }
            .tag(Tabs.token)
        }
        .padding(20)
        .frame(minWidth: 500, maxWidth: 500)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
