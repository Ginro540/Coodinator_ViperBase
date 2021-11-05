//
//  UIViewController+Lifecycle.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import RxSwift
import RxCocoa

extension UIViewController {
    
    private func trigger(selector: Selector) -> Driver<Void> {
        return rx.sentMessage(selector)
            .map{ _ in }
            .asDriver(onErrorJustReturn: ())
    }
    
    var viewWillAppearTrigger: Driver<Void> {
        return trigger(selector:
            #selector(UIViewController.viewWillAppear(_:)))
    }
    
    var viewWillDisappearTrigger: Driver<Void> {
        return trigger(selector:
            #selector(UIViewController.viewDidDisappear(_:)))
    }
    
}
