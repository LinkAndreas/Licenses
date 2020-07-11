//  Copyright © 2020 Andreas Link. All rights reserved.

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let rootView = FileDropArea {
                ContentView()
            }
            .frame(
                minWidth: 650,
                idealWidth: 800,
                maxWidth: .infinity,
                minHeight: 300,
                idealHeight: 600,
                maxHeight: .infinity,
                alignment: .center
            )
            .navigationTitle(L10n.appName)
            .environmentObject(GlobalStore.shared)
            .environmentObject(Store())

            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: rootView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        return
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        return
    }

    func sceneWillResignActive(_ scene: UIScene) {
        return
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        return
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        return
    }
}
