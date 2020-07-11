//
//  Store.swift
//  iOS
//
//  Created by Andreas Link on 27.06.20.
//

import Combine

final class GlobalStore: ObservableObject {
    static let shared: GlobalStore = .init()

    @Published var githubRequestStatus: GithubRequestStatus?

    private init() { /* Singleton */ }

    init(githubRequestStatus: GithubRequestStatus? = nil) {
        self.githubRequestStatus = githubRequestStatus
    }
}
