//
//  UIViewController+SetTitle.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/30.
//

import UIKit

extension UIViewController {
    
    func setTitle(_ title: String, andImage image: UIImage?) {
        let titleLbl = createTitleLabel(title)
        let titleView = UIStackView(arrangedSubviews: [titleLbl])
        titleView.axis = .horizontal
        titleView.spacing = 6.0
        
        let menu = UIBarButtonItem()
        menu.image = image
        
        //navigationItem.leftBarButtonItem = menu
        navigationItem.titleView = titleView
        setNavigationBarColor()
    }
    
    func setTitle(_ title: String) {
        let titleLbl = createTitleLabel(title)
        navigationItem.titleView = titleLbl
        setNavigationBarColor()
     }
    
    func setTitle(_ title: String, menuButton: UIBarButtonItem) {
        
        let titleLbl = createTitleLabel(title)
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.titleView = titleLbl
        setNavigationBarColor()
    }
    
    /// タイトルラベルの生成
    /// - Parameter title: タイトルラベルの文字列(画面名)
    /// - Returns: UILabelのインスタンス
    private func createTitleLabel(_ title: String) -> UILabel {

        let titleLbl = UILabel()
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
        let envName = UserDefaultsConfig.envName
        titleLbl.text = "(\(envName)) \(title) Build \(build ?? "?")"
        titleLbl.textColor = R.color.navigatonColor()
        titleLbl.font = UIFont.systemFont(ofSize: 16.0, weight: .black)

        return titleLbl
    }

    /// ナビゲーションバー色設定
    func setNavigationBarColor() {
        let envColor = UserDefaultsConfig.envColor
        navigationController?.navigationBar.barTintColor =  UIColor.fromHex(hex: envColor, alpha: 1)
    }
}
