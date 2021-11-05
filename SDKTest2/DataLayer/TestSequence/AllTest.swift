//
//  AllTest.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/06/06.
//

import Foundation

struct AllTestSequence {
    
    /// 一括テスト
    static func allTestStart(testData: [TestCaseV4], accountId: String){
        
        guard !testData.isEmpty else {
            return
        }
        
        // 一括テスト開始
        TestHelper.startFullTest()
        // 一括テスト実施
        for test in testData {
            TestHelper.testStart(testCase: test, isFullTest: true, accountId: accountId)
        }
        // 一括テスト終了
        TestHelper.endFullTest()
    }
}

