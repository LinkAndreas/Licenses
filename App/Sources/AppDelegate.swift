//  Copyright © 2020 Andreas Link. All rights reserved.

import Cocoa
import Combine
import ComposableArchitecture
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    lazy var appReducer: Reducer<AppState, AppAction, AppEnvironment> = {
        let reducer: Reducer<AppState, AppAction, AppEnvironment> = .init { state, action, environment in
          switch action {
          case let .searchManifests(path):
            return ManifestCollector.search(at: path)
                .map(AppAction.processManifests)
                .receive(on: RunLoop.main)
                .eraseToEffect()

          case let .processManifests(manifests):
            var repositories: [GithubRepository] = ManifestDecoder.decode(manifests)
            repositories = [GithubRepository](Set<GithubRepository>(repositories))
            state.repositories = repositories

            return .init(
                value: repositories.contains(
                    where: { $0.packageManager == .cocoaPods }
                ) ? .fetchCocoaPodsMetaData : .fetchLicenses
            )

          case .fetchCocoaPodsMetaData:
            let publishers = state.repositories
                .filter({ $0.packageManager == .cocoaPods })
                .publisher
                .flatMap(maxPublishers: .max(1), CocoaPodsRepositoryProcessor.process)
                .collect()
                .map(AppAction.updateCocoaPodsRepositories)
                .receive(on: RunLoop.main)
                .eraseToEffect()

            return .concatenate(publishers)

          case .fetchLicenses:
            let publishers = state.repositories
                .publisher
                .flatMap(maxPublishers: .max(1), LicenseProcessor.process)
                .collect()
                .map(AppAction.updateRepositories)
                .receive(on: RunLoop.main)
                .eraseToEffect()

            return .concatenate(publishers)

          case let .updateCocoaPodsRepositories(repositories):
            state.repositories = repositories
            return .init(value: .fetchLicenses)

          case let .updateRepositories(repositories):
            state.repositories = repositories
            return .none

          case let .selectRepository(repository):
            state.selectedRepository = repository
            return .none

          case let .changeIsTargeted(isTargeted):
            state.isTargeted = isTargeted
            return .none
          }
        }
        return reducer
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let store = Store(
          initialState: AppState(),
          reducer: appReducer,
          environment: AppEnvironment()
        )
        let contentView: some View = FileDropArea<ContentView>(store: store) {
            ContentView(store: store)
        }

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.title = "Licenses"
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        return
    }
}

extension Collection where Element: Publisher {
    func serialize() -> AnyPublisher<Element.Output, Element.Failure> {
        return self.dropFirst().reduce(self.first!.eraseToAnyPublisher()) {
            $0.append($1).eraseToAnyPublisher()
        }
    }
}
