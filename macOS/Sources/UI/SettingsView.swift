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
            }
        }.padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
