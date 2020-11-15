//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general
    }

    @AppStorage("token") private var token: String = ""

    var body: some View {
        TabView {
            Form {
                Section(header: Text(L10n.Settings.Section.GithubAccessToken.title)) {
                    HStack {
                        TextField(
                            L10n.Settings.Section.GithubAccessToken.placeholder,
                            text: $token
                        )
                        Button(
                            action: { token = self.token },
                            label: { Text(L10n.Settings.Section.GithubAccessToken.Button.title) }
                        )
                    }
                    Text(L10n.Settings.Section.GithubAccessToken.subtitle)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }.tabItem {
                Label("General", systemImage: "gear")
            }
            .tag(Tabs.general)
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
