//
//  UserDefaultSetting.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/29.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserDefaultsConfig {

    /// テストケースファイル名
    @UserDefault(key: "testCaseFileName", defaultValue: "")
    static var testCaseFileName: String

    /// 環境ID
    @UserDefault(key: "envId", defaultValue: "")
    static var envId: String

    /// 環境名
    @UserDefault(key: "envName", defaultValue: "")
    static var envName: String

    /// 環境URL
    @UserDefault(key: "envUrl", defaultValue: "")
    static var envUrl: String

    /// 環境設定色
    @UserDefault(key: "envColor", defaultValue: "")
    static var envColor: String

    /// アカウントID
    @UserDefault(key: "accountId", defaultValue: "")
    static var accountId: String

    /// ユーザー名
    @UserDefault(key: "userName", defaultValue: "")
    static var userName: String

    /// パスワード
    @UserDefault(key: "password", defaultValue: "")
    static var password: String

    /// キュー監視使用フラグ
    @UserDefault(key: "useQueueObserver", defaultValue: false)
    static var useQueueObserver: Bool
    
    /// Push用メンバId
    @UserDefault(key: "pushMemberId", defaultValue: "")
    static var pushMemberId: String

    /// 最後に使用したメンバId
    @UserDefault(key: "lastMemberId", defaultValue: "")
    static var lastMemberId: String

    /// 最後に使用したセッションId
    @UserDefault(key: "lastSessionId", defaultValue: "")
    static var lastSessionId: String

    /// 最後に使用したセッションId
    @UserDefault(key: "deviceToken", defaultValue: "")
    static var deviceToken: String
    

}
