//
//  SettingUseCase.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/06/02.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import RxSwift

struct SettingUseCase {
    
    private let useRepository: UserRepository
    
    init(useRepository: UserRepository) {
        self.useRepository = useRepository
    }
    
    func loadEnvSettings() -> Single<[EnvSetting]?>{
        self.useRepository.getEnvSettingFileRead()
    }
    func loadRtaAccounts() -> Single<[RtaAccount]?>{
        self.useRepository.getRtaAccountFileRead()
    }
}
