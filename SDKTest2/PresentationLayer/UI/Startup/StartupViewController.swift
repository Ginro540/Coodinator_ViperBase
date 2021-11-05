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
    
    private let getInitSettingJson = PublishRelay<Void>()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        LogFile.write("timestamp,latitude,longitude,altitude\n")
    }
    
    private func bindViewModel() {
        let input = StartupViewModel.Input(
            trigger: self.viewWillAppearTrigger,
            getInitSettingJsonEvent: self.getInitSettingJson.asObservable()
        )
        
        let output = self.viewModel.transform(input: input)
        output.testCase
            .drive(onNext: {  [weak self] testCase in
                if testCase == "" {
                    self?.getInitSettingJson.accept(())
                }else {
                    self?.flowDelegate.move()
                }
            }).disposed(by: bag)
        
        output.settingJson
            .drive(onNext: {  [weak self] _ in
                self?.flowDelegate.move()
            }).disposed(by: bag)
        
        
    }
}

