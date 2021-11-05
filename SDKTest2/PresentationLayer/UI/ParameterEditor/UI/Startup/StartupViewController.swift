//
//  StartupViewController.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import UIKit
import RxSwift
import RxCocoa

protocol StartupFlowDelegate {
    func move()
}

class StartupViewController: UIViewController {
    
    var flowDelegate: StartupFlowDelegate!
    var viewModel:StartupViewModel!
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindViewModel()
        
        guard let url = Bundle.main.url(forResource: "testcase_v4-0-0",withExtension: "json") else {
            fatalError()
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
    }
    
    private func bindViewModel() {
        
        
        
    }
}

