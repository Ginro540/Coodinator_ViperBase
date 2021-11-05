//
//  MainContentCoordinator.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/30.
//

import UIKit

enum ScreenChange {
    case MainTable
    case Setting
    case history
}


final class MainContentCoordinator: RootViewCoordinator {
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = R.storyboard.mainTable.mainContentNavigationController()!
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        return navigationController
    }()
    
    func start() {
        self.showMainContentTab()
    }
    
    private func showMainContentTab() {
        
        guard let mainTableViewController = navigationController.topViewController as? MainTableViewController else {
            return
        }
        mainTableViewController.viewModel = Injection.makeAssembler().resolve()
        mainTableViewController.delegate = self
        var viewControllers: [UIViewController] = []
        viewControllers.append(mainTableViewController)

        self.navigationController.setViewControllers(viewControllers, animated: false)
    }
}

extension MainContentCoordinator:FlowDelegate{
    func move(moveMassage: ScreenChange) {

        switch moveMassage {
        case .Setting:
            self.moveToSetting()
        case .MainTable:
            self.moveToMainTable()
        case .history:
            self.moveToHistory()
        }
    }
    
    func moveToSetting() {
        
        let controller = R.storyboard.setting.settingViewController()!
        controller.viewModel = Injection.makeAssembler().resolve()
        var viewControllers: [UIViewController] = []
        controller.delegate = self
        viewControllers.append(controller)
        self.navigationController.setViewControllers(viewControllers, animated: false)
    }
    func moveToHistory() {
        let controller = R.storyboard.testHistory.testHistoryViewController()!
        controller.viewModel = Injection.makeAssembler().resolve()
        controller.delegate = self
        var viewControllers: [UIViewController] = []
        viewControllers.append(controller)

        self.navigationController.setViewControllers(viewControllers, animated: false)
    }
    func moveToMainTable() {
        let controller = R.storyboard.mainTable.mainTableViewController()!
        controller.viewModel = Injection.makeAssembler().resolve()
        controller.delegate = self
        var viewControllers: [UIViewController] = []
        viewControllers.append(controller)
        self.navigationController.setViewControllers(viewControllers, animated: false)
    }
}
