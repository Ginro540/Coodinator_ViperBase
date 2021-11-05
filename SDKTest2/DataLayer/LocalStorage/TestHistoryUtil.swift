//
//  TestHistoriesUtil.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/27.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

/// テスト履歴Utility
struct TestHistoryUtil {
    
    /// テスト履歴データ取得(Realm)
    ///
    ///　### Realmからテスト履歴データを取得する
    /// - Returns: テスト履歴データ
    static func getTestHistoryData() -> [TestRecord]? {
        var testRecords: [TestRecord]? = []
        let realm = try! Realm()

        // ダミーデータの挿入
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//        for temp in generateDummyTestHistory() {
//            try! realm.write {
//                let realmObj = TestRecordRealm()
//                realmObj.testRecord = temp
//                realm.add(realmObj)
//            }
//        }

        let testRecordRealms = realm.objects(TestRecordRealm.self)
        for testRecordRealm in testRecordRealms.sorted(byKeyPath: "identifier", ascending: false) {
            testRecords?.append(testRecordRealm.testRecord!)
        }
        return testRecords
    }
    
    
    /// テスト履歴データ登録(Realm)
    ///
    /// ### Realmにテスト記録データを登録する
    ///
    /// すでに登録済みの場合は....
    /// - Parameter testRecord: テスト記録
    static func setTestHistoryData(_ testRecord: TestRecord) {
        let realm = try! Realm()

        // ダミーデータの挿入
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let realmObj = TestRecordRealm()
        realmObj.testRecord = testRecord
        if realm.object(ofType: TestRecordRealm.self, forPrimaryKey: realmObj.getPrimaryKey()) == nil {
            try! realm.write {
                realm.add(realmObj, update: .all)
            }
        }
    }
}


// MARK: ダミーのため後日削除
private func generateDummyTestHistory() -> [TestRecord] {

    var items: [TestRecord] = []

    let calendar = Calendar(identifier: .gregorian)

    for i in 0..<100 {
        let ltrs: [String] =
            [
                "A", "B", "C", "D", "E",
                "F", "G", "H", "I", "J",
                "K", "L", "M", "N", "O",
                "P", "Q", "R", "S", "T",
                "U", "V", "W", "X", "Y",
                "Z", "XYZ"
            ]
        var apiKind: TestCaseV4.ApiKind = TestCaseV4.ApiKind.TRACK
        switch (i % 15) {
        case 0:
            apiKind = TestCaseV4.ApiKind.TRACK
            break
        case 1:
            apiKind = TestCaseV4.ApiKind.EVENT
            break
        case 2:
            apiKind = TestCaseV4.ApiKind.RECOMMEND
            break
        case 3:
            apiKind = TestCaseV4.ApiKind.POPUPRECOMMEND
            break
        case 4:
            apiKind = TestCaseV4.ApiKind.CLICK
            break
        case 5:
            apiKind = TestCaseV4.ApiKind.EVENT_CLICK
            break
        case 6:
            apiKind = TestCaseV4.ApiKind.CONVERSION
            break
        case 7:
            apiKind = TestCaseV4.ApiKind.IDENTIFY
            break
        case 8:
            apiKind = TestCaseV4.ApiKind.OPT_IN
            break
        case 9:
            apiKind = TestCaseV4.ApiKind.OPT_OUT
            break
        case 10:
            apiKind = TestCaseV4.ApiKind.TEST_ALL
            break
        case 11:
            apiKind = TestCaseV4.ApiKind.IOS_RECOMMEND_COMPLETION_HANDLER_NIL
            break
        case 12:
            apiKind = TestCaseV4.ApiKind.IOS_TRACK_COMPLETION_HANDLER_NIL
            break
        case 13:
            apiKind = TestCaseV4.ApiKind.API_KIND_OUT_OF_ALL
            break
        case 14:
            apiKind = TestCaseV4.ApiKind.TRACK_AND_PRESENT_POPUPRECOMMEND
            break
        default:
            break
        }
        var paramType: TestCaseV4.ParamType = TestCaseV4.ParamType.EDITABLE
        switch (i % 15) {
        case 0:
            paramType = TestCaseV4.ParamType.EDITABLE
            break
        case 1:
            paramType = TestCaseV4.ParamType.READ_ONLY
            break
        case 2:
            paramType = TestCaseV4.ParamType.PARAM_TYPE_OUT_OF_ALL
            break
        default:
            break
        }
        var result: TestRecord.TestResult
        switch (i % 3) {
        case 0:
            result = TestRecord.TestResult.ResultOK
            break
        case 1:
            result = TestRecord.TestResult.ResultNG
            break
        case 2:
            result = TestRecord.TestResult.ResultUnknown
            break
        default:
            result = TestRecord.TestResult.ResultOK
            break
        }
        var date = Calendar.current.date(from: DateComponents(year: 2021, month: 5, day: 1, hour: 0, minute: 0, second: 0))!
        date = Calendar.current.date(byAdding: .second, value: i + 2, to: date)!
        date = Calendar.current.date(byAdding: .minute, value: i + 1, to: date)!
        date = Calendar.current.date(byAdding: .hour, value: i + 0, to: date)!
        date = Calendar.current.date(byAdding: .day, value: i + 1, to: date)!
        let index = i % 27
        let suffix = "\(ltrs[index % 27])"
        let prefix = "\(suffix)" + (((i % 27) == 26) ? "" : "\(suffix)\(suffix)")

        items.append(generateDummyTestRecord(prefix: "\(prefix)", memberID: "秘密結社のメンバー\(suffix)", apiKind: apiKind, paramTypeAccountId: paramType, testDate: calendar.date(from: DateComponents(year: calendar.component(.year, from: date), month: calendar.component(.month, from: date), day: calendar.component(.day, from: date), hour: calendar.component(.hour, from: date), minute: calendar.component(.minute, from: date), second: calendar.component(.second, from: date)))!, testResult: result))

    }

    return items
}

private func generateDummyTestRecord(prefix: String, memberID: String?, apiKind: TestCaseV4.ApiKind, paramTypeAccountId: TestCaseV4.ParamType, testDate: Date, testResult: TestRecord.TestResult) -> TestRecord {

    let recomList = [
        ["Recom Resp Contents \(prefix)01": "Recom Resp SessionId \(prefix)01"],
        ["Recom Resp Contents \(prefix)02": "Recom Resp SessionId \(prefix)02"],
        ["Recom Resp Contents \(prefix)03": "Recom Resp SessionId \(prefix)03"],
        ["Recom Resp Contents \(prefix)04": "Recom Resp SessionId \(prefix)04"],
        ["Recom Resp Contents \(prefix)05": "Recom Resp SessionId \(prefix)05"],
    ]
    let expectContents = ExpectContents(recommendResponseList: recomList, resultType: "これが結果期待値[\(prefix)]や")

    //    let testCase = TestCaseV4(title: "だみーてすとのたいとる", apiKind: TestCaseV4.ApiKind.CLICK!, testAllTarget: true, testParameters: nil, paramTypeAccountId: "あかうんとあいで", expectContents: expectContents, debugMode: false)
    let testCase = TestCaseV4(title: "だみーてすとのたいとる\(prefix)", apiKind: apiKind, testAllTarget: true, testParameters: nil, paramTypeAccountId: paramTypeAccountId, expectContents: expectContents, debugMode: false)


    let appKey = [
        "item1_code": "\(prefix)じゅげむじゅげむごこうのすれきれかいわれすいぎょのすいぎょうまつうんぎょうまつくうあるとことに",
        "item2_code": "\(prefix)じゅげむじゅげむごこうのすれきれかいわれすいぎょのすいぎょうまつうんぎょうまつくうあるとことに",
        "item3_code": "\(prefix)じゅげむじゅげむごこうのすれきれかいわれすいぎょのすいぎょうまつうんぎょうまつくうあるとことに",
        "item4_code": "\(prefix)じゅげむじゅげむごこうのすれきれかいわれすいぎょのすいぎょうまつうんぎょうまつくうあるとことに",
        "item5_code": "\(prefix)じゅげむじゅげむごこうのすれきれかいわれすいぎょのすいぎょうまつうんぎょうまつくうあるとことに",
    ]
    let recomAppKey = [
        "c1": "\(prefix)いろはにほへとちりぬるをわかよへのへのもへじ",
        "c2": "\(prefix)いろはにほへとちりぬるをわかよへのへのもへじ",
        "c3": "\(prefix)いろはにほへとちりぬるをわかよへのへのもへじ",
        "c4": "\(prefix)いろはにほへとちりぬるをわかよへのへのもへじ",
        "c5": "\(prefix)いろはにほへとちりぬるをわかよへのへのもへじ",
    ]
    let testParam = testParameters(memberId: memberID, hostName: "\(prefix)おれは男や", location: "\(prefix)どこで映画とってんねん", referrer: "\(prefix)あっしには関わりのねえことで", userAgent: "ゆーざーえーじぇんと\(prefix)", ipAddress: "\(prefix) 123.456.678.900", elementIds: ["Element \(prefix)01", "Element \(prefix)02", "Element \(prefix)03", "Element \(prefix)04", "Element \(prefix)05"], appKeys: appKey, recommendAppKeys: recomAppKey)


    let rcvContents = ResponseContents(
        responseDatas: [
            "\(prefix)-Item01": "Value01",
            "\(prefix)-Item02": "Value02",
            "\(prefix)-Item03": "Value03",
        ],
        responseLists: [
            "recommendResponseList": [[
                "contents": "\(prefix) GitKraken is another one of the best GUI Git clients. It is considered to be one of the most attractive among Git clients. Besides, it comes with great UI, features, and themes. Also, it looks exciting and comes with a lot of features when compared with any other GUI Git client. Furthermore, it has an intuitive UI/UX. It also has a merge Conflict Editor.",
                "sessionId": "This[\(prefix)] is value of Session ID",
                "Dummy": "This[\(prefix)] is Dummy"
            ]],
            "\(prefix)-XYZ": [[
                "1st Item01": "Value01",
                "1st Item02": "Value02",
                "1st Item03": "Value03",
            ],[
                "2nd Item01": "Value01",
                "2nd Item02": "Value02",
                "2nd Item03": "Value03",
            ]]
        ]
    )
    let testRecord = TestRecord(testCase: testCase, testParameter: testParam, isFullTest: false, sessionId: "Session #\(prefix)123", accountId: "赤うんと\(prefix)", testDate: testDate, receivedContents: rcvContents, testResult: testResult)
    
    return testRecord
}
