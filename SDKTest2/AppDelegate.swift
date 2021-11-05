//
//  AppDelegate.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/17.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import UIKit
import SideMenu

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) {granted, error in
            if error != nil {
                // エラー時の処理
                return
            }
            if granted {
                // デバイストークンの要求
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        guard window != nil else {
            return true
        }
        self.startAppCoordinator()
        return true
    }


    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    private func startAppCoordinator() {
        let appCoordinator = AppCoordinator(window: self.window!)
        appCoordinator.start()
    }
}

extension AppDelegate {

    // ③ プッシュ通知の利用登録が成功した場合
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        UserDefaultsConfig.deviceToken = token
    }

    // ④ プッシュ通知の利用登録が失敗した場合
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register to APNs: \(error)")
    }
}

