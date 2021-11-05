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
    func move() {
        
    }
}
