//
//  TestRecord.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/23.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation

/// テスト記録データ
struct TestRecord: Codable {
    
    /// テスト結果
    enum TestResult: Int, Codable {
        /// テスト結果OK
        case ResultOK = 0
        /// テスト結果NG
        case ResultNG = 1
        /// 要確認項目※テストパラメータ編集あり
        case ResultUnknown = 2
    }
    /// テストケース
    var testCase: TestCaseV4
    /// テストパラメータ(テスト実施時)
    var testParameter: testParameters
    /// 全テストフラグ
    var isFullTest: Bool
    /// 効果測定ID
    var sessionId: String
    /// アカウントID
    var accountId: String
    /// テスト実施日
    var testDate: Date
    /// 受信データ内容
    var receivedContents: ResponseContents?
    /// テスト結果
    var testResult: TestResult
}
