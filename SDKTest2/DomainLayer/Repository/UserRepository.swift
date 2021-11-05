//
//  UserRepository.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import RxSwift

protocol UserRepository {
    func getTestCase() -> Single<String>
    func getFileRead() -> Single<[TestCaseV4]?>
    func getTestHistory() -> Single<[TestRecord]?>
    func getEnvSettingFileRead() -> Single<[EnvSetting]?>
    func getRtaAccountFileRead() -> Single<[RtaAccount]?>
    func getTestGroupFileRead() -> Single<[testItem]?>
    func allTestStart(testData:[TestCaseV4],accountId:String)  -> Single<Void>
}

struct UserRepositoryImpl: UserRepository {

    // Json読み込み
    private let appFileRead: AppFileRead
    private let appUserDefaults: AppUserDefaults
    private let appTestHistoryRead: AppTestHistoryRead
    private let appAllTest: AppAllTest

    init(appFileRead: AppFileRead,
         appUserDefaults: AppUserDefaults,
         appTestHistoryRead: AppTestHistoryRead,
         appAllTest: AppAllTest) {
        self.appFileRead = appFileRead
        self.appUserDefaults = appUserDefaults
        self.appTestHistoryRead = appTestHistoryRead
        self.appAllTest = appAllTest
    }
    
    func getFileRead() -> Single<[TestCaseV4]?> {
        self.appFileRead.getLocalJsonData()
    }
    
    func getTestGroupFileRead() -> Single<[testItem]?> {
        self.appFileRead.getTestGroupJson()
    }
    
    
    func getEnvSettingFileRead() -> Single<[EnvSetting]?> {
        self.appFileRead.getEnvSettingJson()
    }
    
    func getRtaAccountFileRead() -> Single<[RtaAccount]?> {
        self.appFileRead.getRtaAccountJson()
    }
    
    func getTestCase() -> Single<String> {
        self.appUserDefaults.getTestCase()
    }
    
    func getTestHistory() -> Single<[TestRecord]?> {
        self.appTestHistoryRead.getTestHistory()
    }
    
    func allTestStart(testData: [TestCaseV4], accountId: String) -> Single<Void> {
        self.appAllTest.allTestStart(testData: testData, accountId: accountId)
    }
}
