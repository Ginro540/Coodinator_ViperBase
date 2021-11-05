//
//  RootViewCoordinator.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//
import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    /// Add a Child coordinator to the parent
    public func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    /// Remove a child coordinator to the parent
    public func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
    
    public func removeAllChildCoordinator() {
        self.childCoordinators.removeAll()
    }
}

protocol RootViewControllerProvider: class {
    var rootViewController: UIViewController { get }
}

typealias RootViewCoordinator = Coordinator & RootViewControllerProvider
