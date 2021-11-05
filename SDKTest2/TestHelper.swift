//
//  TestHelper.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/18.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation
import UIKit

/// テスト実施用クラス
struct TestHelper {

    static var testHelperDelegate: TestHelperDelegate?
    static var testRecord: TestRecord?
    static var isProcessing: Bool = false

    
    /// 一括テスト開始
    static func startFullTest() {
        let testParam = testParameters()
        let testCase = TestCaseV4(title: "▲▲▲ 一括テスト開始 ▲▲▲", apiKind: .TEST_ALL, testAllTarget: true, testGroups: nil, testParameters: nil, paramTypeAccountId: nil, expectContents: nil, debugMode: nil, error: nil)
        let testRecord = TestRecord(testCase: testCase, testParameter: testParam, isFullTest: true, sessionId: "", accountId: "", testDate: Date(), receivedContents: nil, testResult: .ResultUnknown)
        // 一括テスト開始を保存
        TestHistoryUtil.setTestHistoryData(testRecord)
    }
    
    /// 一括テスト終了
    static func endFullTest() {
        let testParam = testParameters()
        let testCase = TestCaseV4(title: "▼▼▼ 一括テスト終了 ▼▼▼", apiKind: .TEST_ALL, testAllTarget: true, testGroups: nil, testParameters: nil, paramTypeAccountId: nil, expectContents: nil, debugMode: nil, error: nil)
        let testRecord = TestRecord(testCase: testCase, testParameter: testParam, isFullTest: true, sessionId: "", accountId: "", testDate: Date(), receivedContents: nil, testResult: .ResultUnknown)
        // 一括テスト開始を保存
        TestHistoryUtil.setTestHistoryData(testRecord)
    }
    

    /// テスト実行開始 ※メイン画面から
    ///
    ///  全テストの場合は実行せず
    ///  直近のテスト結果は「static testRecord」から取得可
    /// - Parameters:
    ///   - testCase: テストケース
    ///   - isFullTest: 全テストフラグ
    ///   - accountId: アカウントID
    static func testStart(testCase: TestCaseV4, isFullTest: Bool, accountId: String) {
        guard var testParameter = testCase.testParameters else {
            return
        }
        // メイン画面から呼ばれる場合はメンバ値を変換する
        testParameter.memberId = convertMemberId(testParameter.memberId ?? "")
        testStart(testCase: testCase, testParameter: testParameter, isModified: false, isFullTest: isFullTest, accountId: accountId)
    }

    /// テスト実行開始 ※パラメータ編集画面から
    ///
    ///  全テストの場合は実行せず
    ///  直近のテスト結果は「static testRecord」から取得可
    /// - Parameters:
    ///   - testCase: テストケース
    ///   - pTestParameter: テストパラメータ
    ///   - isModified: テストパラメータ編集フラグ
    ///   - isFullTest: 全テストフラグ
    ///   - accountId: アカウントID
    static func testStart(testCase: TestCaseV4, testParameter pTestParameter: testParameters, isModified: Bool, isFullTest: Bool, accountId: String) {

        // テスト情報を初期化
        testRecord = nil
        
        // API種別がnilの場合、テストは行わない
        guard let apiKind = testCase.apiKind else {
            return
        }
        // API種別が全テストの場合、処理を終了する
        if apiKind == TestCaseV4.ApiKind.TEST_ALL {
            return
        }
        
        // ログを出力する
        LogFile.writeln("Test Start title: \(testCase.title ?? "")")
        
        // テスト実行中にRe-entrantしない前提
        testHelperDelegate = nil

        // メソッド内部で中身を書き換えるため引数のコピーを作る
        var testParameter = pTestParameter

        // クリックの場合直前の効果測定IDを取得する
        var sessionId = ""
        switch apiKind {
        case TestCaseV4.ApiKind.CLICK,
             TestCaseV4.ApiKind.EVENT_CLICK:
            sessionId = UserDefaultsConfig.lastSessionId
            if !sessionId.isEmpty {
                if testParameter.appKeys == nil {
                    testParameter.appKeys = [:]
                }
                testParameter.appKeys![SESSION_ID_KEY] = sessionId
            }
            break
        default:
            break
        }

        // テストデータ生成(テスト条件のみ)
        testRecord = TestRecord(testCase: testCase, testParameter: testParameter, isFullTest: isFullTest, sessionId: sessionId, accountId: accountId, testDate: Date(), receivedContents: nil, testResult: TestRecord.TestResult.ResultOK)

        // 接続初期化
        let error = Rtoaster.setup(withAccountId: accountId, basicUsername: UserDefaultsConfig.userName, basicPassword: UserDefaultsConfig.password, pushEnvironmentType: PushSandbox, defaultAuthorizationStatus: RtoasterAuthorizationStatusAuthorized)

        // 接続初期化失敗
        if error != nil {
            LogFile.writeln("error \(error!)")
        }
        // 接続初期化成功
        else {
            LogFile.writeln("Rtoaster SDK ver \(Rtoaster.getVersionName() ?? "Unknown") initialized.")
        }

        // エンドポイントはここで設定しないとエラーになるためここで設定
        let rtoasterProxyUrl = UserDefaultsConfig.envUrl
        LogFile.writeln("Rtoaster Proxy URL: \(rtoasterProxyUrl)")
        Rtoaster.setApiBaseUrl(rtoasterProxyUrl)

        if let memberId = testParameter.memberId {
            // メンバ値設定
            Rtoaster.setMemberId(memberId)
        }

        // リファラ設定※このコマンドはdeprecated ... やけどtrackとかの引数で呼ぶと通信でエラーがでるため残す
        Rtoaster.setReferrer(testParameter.referrer)

        // ホスト名設定
        Rtoaster.setSiteHostname(testParameter.hostName ?? "")

        // デバッグモード設定
        Rtoaster.setDebugMode(testCase.debugMode ?? false)

        // トラッキングメンバ値
        let trackingMemberId = Rtoaster.getTrackingMemberId()
        LogFile.writeln("Tracking member id: \(trackingMemberId ?? "")")

        // 非同期制御フラグ初期化
        isProcessing = true
        var isPopMode = false

        switch apiKind {
        // ページトラッキング
        case TestCaseV4.ApiKind.TRACK,
             TestCaseV4.ApiKind.CLICK,
             TestCaseV4.ApiKind.CONVERSION:
            Rtoaster.track(withLocation: testParameter.location, withAppKeys: testParameter.appKeys ?? [:], withCompletionHandler: { result in

                makeTestResult(result: result, isPageTracking: true, isModified: isModified, testCase: testCase, testRecord: &testRecord!)

                isProcessing = false
            })
            break
        // イベントトラッキング
        case TestCaseV4.ApiKind.EVENT,
             TestCaseV4.ApiKind.EVENT_CLICK:
            Rtoaster.event(withLocation: testParameter.location, withAppKeys: testParameter.appKeys ?? [:], withCompletionHandler: { result in

                makeTestResult(result: result, isPageTracking: false, isModified: isModified, testCase: testCase, testRecord: &testRecord!)

                isProcessing = false
            })
            break
        // レコメンド
        case TestCaseV4.ApiKind.RECOMMEND:
            Rtoaster.trackRecommend(withElementIds: testParameter.elementIds!, withLocation: testParameter.location, withAppKeys: testParameter.appKeys ?? [:], withRecommendAppKeys: testParameter.recommendAppKeys ?? [:], withCompletionHandler: { result in

                makeTestResult(result: result, isPageTracking: false, isModified: isModified, testCase: testCase, testRecord: &testRecord!)

                // 効果測定IDを保存(複数レコメンドがある場合は最初の効果測定IDを保存する)
                if let firstSessionId = getFirstSessionId(testRecord: testRecord!) {
                    UserDefaultsConfig.lastSessionId = firstSessionId
                }

                isProcessing = false
            })
            break
        // レコメンドポップアップ
        case TestCaseV4.ApiKind.POPUPRECOMMEND:
            isPopMode = true
            testHelperDelegate = TestHelperDelegate()

            Rtoaster.presentRecommendPopup(withElementId: testParameter.elementIds![0], with: testHelperDelegate!, with: activeWindowScene)

            // 実行待機
            Thread.sleep(forTimeInterval: SLEEP_TIME_TEST)
            break
        case TestCaseV4.ApiKind.TRACK_AND_PRESENT_POPUPRECOMMEND:
            isPopMode = true
            testHelperDelegate = TestHelperDelegate()

            // デバッグモード設定
            Rtoaster.setDebugMode(true)
            let parameter = RtoasterTrackAndPresentRecommendPopupParameter()
            parameter.setLocation(testParameter.location ?? "")
            parameter.setReferrer(testParameter.referrer ?? "")
            parameter.setElementId(testParameter.elementIds![0])
            parameter.setAppKeys(testParameter.appKeys)
            parameter.setRecommendAppKeys(testParameter.recommendAppKeys)
            parameter.setDelegate(testHelperDelegate!)
            parameter.setWindowScene(activeWindowScene)

            Rtoaster.trackAndPresentRecommendPopup(with: parameter)

            // 実行待機
            Thread.sleep(forTimeInterval: SLEEP_TIME_TEST)
            break
        // 端末情報の登録
        case TestCaseV4.ApiKind.IDENTIFY:
            // テスト結果OKのテスト情報を作成
            makeTestResult(testRecord: &testRecord!)

            isProcessing = false
            break
        //
        case TestCaseV4.ApiKind.IOS_TRACK_COMPLETION_HANDLER_NIL:
            Rtoaster.track(withLocation: testParameter.location, withAppKeys: testParameter.appKeys ?? [:], withCompletionHandler: nil)

            // 非メンバ値を保存※非メンバ値の項目がなくなったためロジック削除

            // テスト結果OKのテスト情報を作成
            makeTestResult(testRecord: &testRecord!)

            isProcessing = false
            break
        //
        case TestCaseV4.ApiKind.IOS_RECOMMEND_COMPLETION_HANDLER_NIL:
            // ccompletionHandlerがnilを許可しないため
            Rtoaster.trackRecommend(withElementIds: testParameter.elementIds!, withLocation: testParameter.location, withAppKeys: testParameter.appKeys ?? [:], withRecommendAppKeys: testParameter.recommendAppKeys ?? [:], withCompletionHandler: { result in })
            
            // 非メンバ値を保存※非メンバ値の項目がなくなったためロジック削除

            // テスト結果OKのテスト情報を作成
            makeTestResult(testRecord: &testRecord!)

            isProcessing = false
            break
        //
        case TestCaseV4.ApiKind.OPT_IN:
            Rtoaster.opt(in: testParameter.memberId)

            // 非メンバ値を保存※非メンバ値の項目がなくなったためロジック削除

            // テスト結果OKのテスト情報を作成
            makeTestResult(testRecord: &testRecord!)

            isProcessing = false
            break
        //
        case TestCaseV4.ApiKind.OPT_OUT:
            Rtoaster.optOut()

            // テスト結果OKのテスト情報を作成
            makeTestResult(testRecord: &testRecord!)

            isProcessing = false
            break
        default:
            isProcessing = false
            break
        }

        // 処理が終わるまで待機
        for sleepCount in 0...SLEEP_MAX_COUNT {
            if (isProcessing == false) {
                break
            }
            // タイムアウト
            if sleepCount == SLEEP_MAX_COUNT {
                // タイムアウトなったらポップアップは消す
                if isPopMode {
                    Rtoaster.closeRecommendPopup()
                }
                LogFile.writeln("timeout")
                let contents: [String: String] = [ "errorMessage": "timeout" ]
                testRecord!.receivedContents = ResponseContents(responseDatas: contents, responseLists: nil)
                // error プロパティ対応
                if testCase.error ?? false {
                    testRecord!.testResult = .ResultOK
                }
                else {
                    testRecord!.testResult = .ResultNG
                }
                testRecord!.testDate = Date()

                // テスト履歴を保存
                TestHistoryUtil.setTestHistoryData(testRecord!)
            }

            // sleepForTimeInterval の場合runが回らないので、テストアプリ用にrunを回す。
            RunLoop.current.run(until: Date(timeIntervalSinceNow: SLEEP_TIME_TEST))
        }

    }

    /// アクティブなWindowsScene
    private static var activeWindowScene: UIWindowScene? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes.filter({ scene in scene.activationState == .foregroundActive }).first as? UIWindowScene
        }
        return nil
    }

    /// テスト結果判定
    /// - Parameters:
    ///   - result: 受信結果
    ///   - isPageTracking: ページトラッキングAPIフラグ
    ///   - isModified: パラメータ編集フラグ
    ///   - testCase: テストケース
    ///   - testRecord: テスト記録
    private static func makeTestResult(result: RtSessionResult, isPageTracking: Bool, isModified: Bool, testCase: TestCaseV4, testRecord: inout TestRecord) {
        
        // テスト結果がエラーの場合
        if let description = result.error {
            LogFile.writeln("error \(description)")
        }

        // 非メンバ値を保存※非メンバ値の項目がなくなったためロジック削除
        
        // 受信コンテンツフォーマット変換
        var rcvContents: ResponseContents? = nil
        if let rspContents = result.result as? [String: Any?]  {
            rcvContents = ResponseContents()
            for objItem in rspContents {
                let keyName = objItem.key
                if let valItem = objItem.value as? String {
                    if rcvContents!.responseDatas == nil {
                        rcvContents!.responseDatas = [:]
                    }
                    rcvContents!.responseDatas![keyName] = valItem
                }
                else if let arrayItems = objItem.value as? [[String: String]] {
                    if rcvContents?.responseLists == nil {
                        rcvContents!.responseLists = [:]
                    }
                    var items: [[String: String]] = []
                    for arrayItem in arrayItems {
                        var dicItems: [String: String] = [:]
                        for dicItem in arrayItem {
                            dicItems[dicItem.key] = dicItem.value
                        }
                        items.append(dicItems)
                    }
                    rcvContents!.responseLists![keyName] = items
                }
                else {
                    // 予期しないデータタイプ
                    print("Unknown受信データパターン：" + String(reflecting: objItem.value))
                }
            }
        }

        // 受信データをテスト記録に登録
        testRecord.receivedContents = rcvContents

        // パラメータ変更した場合は要目視確認
        if isModified {
            testRecord.testResult = TestRecord.TestResult.ResultUnknown
        }
        // error プロパティ対応
        else if testCase.error ?? false {
//            print("====== ******* error flag is true")
            testRecord.testResult = TestRecord.TestResult.ResultOK
        }
        // 期待値と返却値に差分あり
        else if (!compareResultContents(resultContents: rcvContents, expectContents: testCase.expectContents)) {
            testRecord.testResult = TestRecord.TestResult.ResultNG
        }
        else {
            // ページトラッキングの場合
            if isPageTracking {
                // メンバ値チェック
                let trackingMemberId = Rtoaster.getTrackingMemberId()
                LogFile.writeln("Tracking member id: \(trackingMemberId ?? "")")
                var userId = Rtoaster.getMemberId()
                if userId == nil  {
                    userId = Rtoaster.getNonMemberId()
                }
                testRecord.testResult = userId != trackingMemberId ? TestRecord.TestResult.ResultNG : TestRecord.TestResult.ResultOK
            }
            else {
                testRecord.testResult = TestRecord.TestResult.ResultOK
            }
        }
        
        // テスト履歴を保存
        TestHistoryUtil.setTestHistoryData(testRecord)
    }

    /// 受信結果比較
    /// - Parameters:
    ///   - pResultContents: 受信コンテンツ
    ///   - pExpectContents: 期待値コンテンツ
    /// - Returns: true:一致, false:不一致
    private static func compareResultContents(resultContents pResultContents: ResponseContents?, expectContents pExpectContents: ExpectContents?) -> Bool {

        var isDiff = false

        // 両方のデータが共に nil ならば一致
        if pResultContents == nil && pExpectContents == nil {
            isDiff = false
        }
        // 両方のデータが共に nil でないならば
        else if let resultContents = pResultContents,
                let expectContents = pExpectContents {

            // 期待値にresultTypeの値が存在する場合
            if let resultType = expectContents.resultType {
                let responseDatas = resultContents.responseDatas ?? [:]

                isDiff = isDiff
                        || (responseDatas.count != 1)
                        || (responseDatas["resultType"] != resultType)
            }
            // 期待値にresultTypeの値が存在しない場合
            else {
                // 受信データもデータなしでなければならない
                isDiff = isDiff || ((resultContents.responseDatas?.count ?? 0) != 0)
            }
            
            // 期待値にrecommendResponseListが存在する場合
            if let rcmRespList = expectContents.recommendResponseList, !rcmRespList.isEmpty {
                let responseLists = resultContents.responseLists ?? [:]

                if let targetList = responseLists["recommendResponseList"],
                                    responseLists.count == 1,
                                    targetList.count == rcmRespList.count {
                    for index in 0..<rcmRespList.count {
                        let expItems = rcmRespList[index]
                        let rcvItems = targetList[index]
                        
                        for expItem in expItems {
                            let rcvValue = rcvItems[expItem.key]
                            isDiff = isDiff
                                || (rcvValue == nil)        // 根本的に対象項目がない
                                || (expItem.value != rcvValue && expItem.value != ANY_VALUE)    // 値が期待値と違いかつ期待値がANY_VALUEでないとき
                        }
                    }
                }
                else {
                    isDiff = isDiff || true
                }
            }
            // 期待値にrecommendResponseListが存在しない場合
            else {
                // 受信データリストもデータなしでなければならない
                isDiff = isDiff || ((resultContents.responseLists?.count ?? 0) != 0)
            }
        }
        // どちらかのデータだけが nil の場合
        else {
            isDiff = true
        }

        return !isDiff
    }
    
    /// OKテスト結果判定
    ///
    ///  テスト記録に「テスト結果OK」を記載し、テスト履歴に保存する
    /// - Parameter testRecord: テスト記録
    private static func makeTestResult(testRecord: inout TestRecord) {

        // テスト記録を作成
        testRecord.testResult = TestRecord.TestResult.ResultOK

        // テスト履歴を保存
        TestHistoryUtil.setTestHistoryData(testRecord)
    }


    /// 最初の効果測定IDを取得
    /// - Parameter testRecord: テスト記録
    /// - Returns: 最初の効果測定ID
    private static func getFirstSessionId(testRecord: TestRecord) -> String? {

        if let arrayItems = testRecord.receivedContents?.responseLists?[RECOMMEND_RESPONSE_LIST_SECTION] {
            for dicItems in arrayItems {
                if let firstSessionId = dicItems[RECOMMEND_RESPONSE_LIST_ITEM_SESSION_ID] {
                    return firstSessionId
                }
            }
        }

        return nil
    }
}



/// Rtoaster ポップアップコマンド用Delegate
///
/// Rtoasterのポップアップコマンドに渡すコールバック用のクラス
class TestHelperDelegate: RtoasterPopupDelegate {

    /// イメージをタップした時の挙動
    /// - Parameters:
    ///   - elementId: エレメントID
    ///   - linkDestination: リンク先
    func rtoasterRecommendPopupDidTapImage(_ elementId: String, withLinkDestination linkDestination: String) {
        LogFile.writeln("--- Delegate didRecommendPopupTapImage ---")
        Rtoaster.closeRecommendPopup()

        // テスト記録を作成
        let contents: [String: String] = [ "elementId": elementId, "linkDestination": linkDestination ]
        TestHelper.testRecord!.receivedContents = ResponseContents(responseDatas: contents, responseLists: nil)
        TestHelper.testRecord!.testResult = TestRecord.TestResult.ResultOK

        // 非メンバ値を保存※非メンバ値の項目がなくなったためロジック削除

        // テスト履歴を保存
        TestHistoryUtil.setTestHistoryData(TestHelper.testRecord!)

        // プロセス終了フラグをOFF
        TestHelper.isProcessing = false
    }

    /// 閉じるボタンを押下した時の挙動
    /// - Parameter elementId: エレメントID
    func rtoasterRecommendPopupDidClose(_ elementId: String) {
        LogFile.writeln("--- Delegate didRecommendPopupTapCloseButton ---")
        
        // テスト記録を作成
        let contents: [String: String] = [ "elementId": elementId ]
        TestHelper.testRecord!.receivedContents = ResponseContents(responseDatas: contents, responseLists: nil)
        TestHelper.testRecord!.testResult = TestRecord.TestResult.ResultOK

        // 非メンバ値を保存※非メンバ値の項目がなくなったためロジック削除

        // テスト履歴を保存
        TestHistoryUtil.setTestHistoryData(TestHelper.testRecord!)

        // プロセス終了フラグをOFF
        TestHelper.isProcessing = false
    }

    /// ポップアップエラー時の挙動
    /// - Parameters:
    ///   - elementId: エレメントID
    ///   - error: エラー情報
    func rtoasterRecommendPopupDidFail(_ elementId: String, withError error: Error) {
        LogFile.writeln("--- Delegate didRecommendPopupError ---")

        // テスト記録を作成(localizedFailureReasonはプロトコルErrorに含まれない)
        let contents: [String: String] = [ "error": error.localizedDescription ]
        TestHelper.testRecord!.receivedContents = ResponseContents(responseDatas: contents, responseLists: nil)
        TestHelper.testRecord!.testResult = TestRecord.TestResult.ResultNG

        // 非メンバ値を保存※非メンバ値の項目がなくなったためロジック削除

        // テスト履歴を保存
        TestHistoryUtil.setTestHistoryData(TestHelper.testRecord!)

        // プロセス終了フラグをOFF
        TestHelper.isProcessing = false
    }
}

