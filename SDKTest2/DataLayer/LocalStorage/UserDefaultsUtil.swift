//
//  UserDefaultsUtil.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/21.
//

import Foundation

struct UserDefaultsUtil {
    
    static let userDefaults = UserDefaults.standard
    
    static func getTeatCase(key: String) -> String {
        return userDefaults.string(forKey: key) ?? ""
    }

    static func getStringValue(key: String) -> String {
        return userDefaults.string(forKey: key) ?? ""
    }

}
