//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct SettingsView: View {
    @State private var token: String = Defaults.token

    var body: some View {
        Form {
            Section(header: Text(L10n.Settings.Section.GithubAccessToken.title)) {
                HStack {
                    TextField(
                        L10n.Settings.Section.GithubAccessToken.placeholder,
                        text: $token
                    )
                    Button(
                        action: { Defaults.token = self.token },
                        label: { Text(L10n.Settings.Section.GithubAccessToken.Button.title) }
                    )
                }
                Text(L10n.Settings.Section.GithubAccessToken.subtitle)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding()
        .frame(minWidth: 500, maxWidth: 500)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
