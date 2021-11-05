//
//  File.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import RxSwift

protocol AppFileRead {
    func getLocalJsonData() -> Single<[TestCaseV4]?>
    func getEnvSettingJson() -> Single<[EnvSetting]?>
    func getRtaAccountJson() -> Single<[RtaAccount]?>
    func getTestGroupJson() -> Single<[testItem]?>
}

struct AppFileReadImpl:AppFileRead {
    
    func getLocalJsonData() -> Single<[TestCaseV4]?> {
        return Single.create { observer in
            observer(.success(FileRead.readJson()))
            return Disposables.create()
        }
    }
    
    func getTestGroupJson() -> Single<[testItem]?> {
        return Single.create { observer in
            observer(.success(FileRead.reeadTestGroupJson()))
            return Disposables.create()
        }
    }
    
    
    func getEnvSettingJson() -> Single<[EnvSetting]?> {
        return Single.create { observer in
            observer(.success(FileRead.readEnvSettingJson()))
            return Disposables.create()
        }
    }
    
    func getRtaAccountJson() -> Single<[RtaAccount]?> {
        return Single.create { observer in
            observer(.success(FileRead.readRtaAccountJson()))
            return Disposables.create()
        }
    }
}
