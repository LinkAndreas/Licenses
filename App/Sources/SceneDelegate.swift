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
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
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
