//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI

struct RepositoryList: View {
    @EnvironmentObject var userData: UserData
    @State private var selectedRepository: GitHubRepository?

    var body: some View {
        List(userData.repositories, selection: $selectedRepository) { (repository: GitHubRepository) in
            HStack {
                Text(repository.name)
                    .font(.headline)
                Text(repository.version)
                    .font(.subheadline)
            }.padding()
        }
    }
}

struct RepositoryList_Previews: PreviewProvider {
    static var previews: some View {
        ArtefactPickerView()
    }
}
