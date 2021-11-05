//
//  UIViewController+Alert.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/25.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import UIKit

public extension UIViewController {
    /// Alert表示
    func showAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
    /// ActionSheet表示
    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}
