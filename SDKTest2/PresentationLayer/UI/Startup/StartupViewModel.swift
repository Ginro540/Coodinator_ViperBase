//
//  StartupViewModel.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import RxSwift
import RxCocoa

final class StartupViewModel: ViewModelType{

    struct Input {
        let trigger: Driver<Void>
        let getInitSettingJsonEvent: Observable<Void>
    }
    
    struct Output {
        let testCase: Driver<String>
        let settingJson:Driver<Void>
    }

    private var getTestCaseUseCase:GetTestCaseUseCase
    private var getInitSettingJsonUseCase:GetInitSettingJsonUseCase
    
    init (getTestCaseUseCase:GetTestCaseUseCase,
          getInitSettingJsonUseCase:GetInitSettingJsonUseCase) {
        self.getTestCaseUseCase = getTestCaseUseCase
        self.getInitSettingJsonUseCase = getInitSettingJsonUseCase
    }

    func transform(input: Input) -> Output {
        
        let testCase = input.trigger
            .asObservable()
            .flatMapLatest {
                self.getTestCaseUseCase.run()
            }
            .asDriverOnErrorJustComplete()
        
        let getInitSettingJson = input.getInitSettingJsonEvent
            .asObservable()
            .flatMapLatest {
                self.getInitSettingJsonUseCase.run()
            }
            .asDriverOnErrorJustComplete()

        return Output (
            testCase: testCase,
            settingJson: getInitSettingJson
        )
    }
}
