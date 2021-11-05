//
//  StartupAssembler.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import Foundation
protocol StartupAssembler {
    func resolve() -> StartupViewModel
    func resolve() -> GetTestCaseUseCase
    func resolve() -> UserRepository
    func resolve() -> AppUserDefaults
    func resolve() -> AppFileRead
    func resolve() -> AppTestHistoryRead
    func resolve() -> GetInitSettingJsonUseCase
    func resolve() -> AppAllTest
}

extension StartupAssembler {
    func resolve() -> StartupViewModel {
        return StartupViewModel(getTestCaseUseCase: resolve(),
        getInitSettingJsonUseCase: resolve())
    }
    func resolve() -> GetTestCaseUseCase {
        return GetTestCaseUseCase(useRepository: resolve())
    }
    
    func resolve() -> GetInitSettingJsonUseCase {
        return GetInitSettingJsonUseCase(useRepository: resolve())
    }
    func resolve() -> UserRepository {
        return UserRepositoryImpl(appFileRead: resolve(),
                                  appUserDefaults: resolve(),
                                  appTestHistoryRead: resolve(),
                                  appAllTest: resolve())
    }
    func resolve() -> AppUserDefaults {
        return AppUserDefaultsImpl()
    }
    func resolve() -> AppFileRead {
        return AppFileReadImpl()
    }
    func resolve() -> AppTestHistoryRead {
        return AppTestHistoryReadImpl()
    }
    func resolve() -> AppAllTest {
        return AppAllTestImpl()
    }
    
}
