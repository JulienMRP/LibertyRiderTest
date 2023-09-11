//
//  SceneDelegate.swift
//  LibertyRiders Test
//
//  Created by Perso on 9/7/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
      
        let window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController()
        let coordinator = BreedCoordinator(nav: nav)
        coordinator.start()
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
}

