//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section(header: Text(L10n.Settings.Section.GithubAccessToken.title)) {
                TextField(
                    L10n.Settings.Section.GithubAccessToken.placeholder,
                    text: Binding<String>(
                        get: { return Defaults.token },
                        set: { value in Defaults.token = value }
                    )
                )
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
