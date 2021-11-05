//
//  GetFileReadUseCase.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import RxSwift
import Foundation

struct FileRead {
        
    static func readJson () -> [TestCaseV4]?{
        guard let url = Bundle.main.url(forResource: "test_cases_v4_3",withExtension: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        // JSONデコード処理
        let decoder = JSONDecoder()


        guard let json = try? decoder.decode(ReadJson.self, from: data) else {
            fatalError("JSON読み込みエラー")
        }
        return json.testCases
    }
    
    
    static func reeadTestGroupJson() -> [testItem]? {
        
        guard let url = Bundle.main.url(forResource: "test_groups", withExtension: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        let decoder = JSONDecoder()
        guard let json = try? decoder.decode(TestGroups.self, from: data) else {
            fatalError("JSON読み込みエラー")
        }
        return json.test_groups
    }
    
    static func readEnvSettingJson () -> [EnvSetting]? {
        guard let url = Bundle.main.url(forResource: "env_settings", withExtension: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        // JSONデコード処理
        let decoder = JSONDecoder()
        guard let json = try? decoder.decode(EnvSettingJson.self, from: data) else {
            fatalError("JSON読み込みエラー")
        }
        return json.env_settings
    }
    
    static func readRtaAccountJson () -> [RtaAccount]? {
        guard let url = Bundle.main.url(forResource: "rta_accounts", withExtension: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        // JSONデコード処理
        let decoder = JSONDecoder()
        guard let json = try? decoder.decode(RtaAccountsJson.self, from: data) else {
            fatalError("JSON読み込みエラー")
        }
        return json.rta_accounts
    }
}

