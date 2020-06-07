//  Copyright © 2020 Andreas Link. All rights reserved.

import Combine

final class UserData: ObservableObject {
    @Published var repositories: [GitHubRepository] = []
}
