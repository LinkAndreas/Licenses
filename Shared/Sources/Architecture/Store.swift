//
//  Store.swift
//  iOS
//
//  Created by Andreas Link on 27.06.20.
//

import Combine

final class Store: ObservableObject {
    static let shared: Store = .init()

    @Published var githubRequestStatus: GithubRequestStatus?

    private init() { /* Singleton */ }

    init(githubRequestStatus: GithubRequestStatus? = nil) {
        self.githubRequestStatus = githubRequestStatus
    }
}
