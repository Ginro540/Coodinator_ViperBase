//
//  File.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/21.
//

import Foundation

protocol MainTableAssembler {
    func resolve() -> MainTableViewModel
    func resolve() -> FileReadUseCase
    func resolve() -> UserRepository
    func resolve() -> AppUserDefaults
    func resolve() -> AppFileRead
    func resolve() -> AppTestHistoryRead
    func resolve() -> AppAllTest
    func resolve() -> AlltestUseCase
}

extension MainTableAssembler {
    func resolve() -> MainTableViewModel {
        return MainTableViewModel(fileReadUseCase: resolve(),
                                  allTestUseCase: resolve())
    }
    func resolve() -> FileReadUseCase {
        return FileReadUseCase(useRepository: resolve())
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
    
    func resolve() -> AlltestUseCase {
        return AlltestUseCase(useRepository: resolve())
    }
    
}
