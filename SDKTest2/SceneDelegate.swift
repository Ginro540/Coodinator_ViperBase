//
//  SceneDelegate.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/17.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: scene)
        self.window = window
        window.makeKeyAndVisible()

        let vc = UINavigationController()
        window.rootViewController = vc
        startAppCoordinator()
    }
    
    private func startAppCoordinator() {
        let appCoordinator = AppCoordinator(window: self.window!)
        appCoordinator.start()
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {}

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {}

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {}

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {}

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {}
}


