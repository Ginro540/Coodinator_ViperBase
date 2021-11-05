//
//  AppCoordinator.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import UIKit

extension Notification.Name {
    static let SignOutEvent = Notification.Name("SignOutEvent")
}

final class AppCoordinator: RootViewCoordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private let window: UIWindow
    
    private lazy var navigationController: UINavigationController = {
        guard let navigationController = self.window.rootViewController as? UINavigationController else {
            return UINavigationController()
        }
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start(){
        self.showStartup()
    }
    
    private func showStartup() {
        let controller = R.storyboard.startup.startupViewController()!
        controller.flowDelegate = self
        controller.viewModel = Injection.makeAssembler().resolve()
        self.navigationController.setViewControllers([controller], animated: false)
    }
}


extension AppCoordinator: StartupFlowDelegate {
    /// 画面遷移
    func move() {
        // 起動時処理
        startUpProcess()
        let coordinator = MainContentCoordinator()
        coordinator.start()
        self.addChildCoordinator(coordinator)
        self.navigationController.present(
            coordinator.rootViewController,
            animated: false, completion: nil
        )
    }

    /// 起動時処理
    func startUpProcess() {
        // アーキテクチャ出力
        LogFile.writeln("running on \(SystemInfo.DeviceInfo).")

        // Push設定
        let userName = UserDefaultsConfig.userName
        let password = UserDefaultsConfig.password
        let accountID = UserDefaultsConfig.accountId
        
        LogFile.writeln("initialized.")
    }
}
