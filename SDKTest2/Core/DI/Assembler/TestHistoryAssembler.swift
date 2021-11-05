//
//  TestHistoryAssembler.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/28.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation

protocol TestHistoryAssembler {
    func resolve() -> TestHistoryViewModel
    func resolve() -> TestHistoryUseCase
    func resolve() -> UserRepository
    func resolve() -> AppFileRead
    func resolve() -> AppUserDefaults
    func resolve() -> AppTestHistoryRead
    func resolve() -> AppAllTest
}

extension TestHistoryAssembler {
    func resolve() -> TestHistoryViewModel {
        return TestHistoryViewModel(testHistoryUseCase: resolve())
    }
    func resolve() -> TestHistoryUseCase {
        return TestHistoryUseCase(useRepository: resolve())
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
