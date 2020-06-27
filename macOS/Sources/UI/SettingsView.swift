//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct SettingsView: View {
    @AppStorage("token") private var token: String = ""

    var body: some View {
        Form {
            Section(header: Text(L10n.Settings.Section.GithubAccessToken.title)) {
                TextField(
                    L10n.Settings.Section.GithubAccessToken.placeholder,
                    text: $token
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
