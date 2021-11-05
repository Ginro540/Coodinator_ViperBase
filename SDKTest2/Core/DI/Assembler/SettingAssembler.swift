//
//  SettingAssembler.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/06/02.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation

protocol SettingAssembler {
    func resolve() -> SettingViewModel
    func resolve() -> SettingUseCase
    func resolve() -> UserRepository
    func resolve() -> AppFileRead
    func resolve() -> AppUserDefaults
    func resolve() -> AppTestHistoryRead
    func resolve() -> AppAllTest
}

extension SettingAssembler {
    func resolve() -> SettingViewModel {
        return SettingViewModel(settingUseCase: resolve())
    }
    func resolve() -> SettingUseCase {
        return SettingUseCase(useRepository: resolve())
    }
    func resolve() -> UserRepository {
        return UserRepositoryImpl(appFileRead: resolve(),
                                  appUserDefaults: resolve(),
                                  appTestHistoryRead: resolve(),
                                  appAllTest: resolve())
    }
    func resolve() -> AppFileRead {
        return AppFileReadImpl()
    }
    func resolve() -> AppUserDefaults {
        return AppUserDefaultsImpl()
    }
    func resolve() -> AppTestHistoryRead {
        return AppTestHistoryReadImpl()
    }
    func resolve() -> AppAllTest {
        return AppAllTestImpl()
    }
}
