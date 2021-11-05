//
//  TestRecordRealm.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/29.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation
import RealmSwift

/// テスト記録(Realm用)
class TestRecordRealm : Object {

    @objc private dynamic var identifier: String?
    @objc private dynamic var structData: Data? = nil

    /// プライマリキー値取得
    func getPrimaryKey() -> String? {
        identifier
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    var testRecord : TestRecord? {
        get {
            if let data = structData {
                return try? JSONDecoder().decode(TestRecord.self, from: data)
            }
            return nil
        }
        set {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
            self.identifier = dateFormatter.string(from: newValue!.testDate)
            structData = try? JSONEncoder().encode(newValue)
        }
    }
}
