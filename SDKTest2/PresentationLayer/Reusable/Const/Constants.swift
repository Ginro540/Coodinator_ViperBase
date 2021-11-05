//
//  Constants.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/18.
//

import Foundation

// ========================================
// タイトル名称の定義
// ========================================
let USER_NAME_TITLE = "ユーザー名"
let PASSWORD_TITLE = "パスワード"
let ACCOUNT_ID_TITLE = "アカウントID"
let MEMBER_ID_TITLE = "メンバ値"
let NON_MEMBER_ID_TITLE = "非メンバ値"
let CONTENTS_TITLE = "コンテンツ"
let RECEIVED_CONTENTS_TITLE = "返却値"
let EXPECTED_CONTENTS_TITLE = "期待値"
let HOST_NAME_TITLE = "ホスト名"
let LOCATION_TITLE = "ロケーション"
let REFERER_TITLE = "リファラ"
let USER_AGENT_TITLE = "ユーザーエージェント"
let IP_ADDRESS_TITLE = "IPアドレス"
let ELEMENT_IDS_TITLE = "エレメントID"
let APP_KEYS_TITLE = "アプリキー"
let RECOMMEND_APP_KEYS_TITLE = "レコメンドアプリキー"


/// セクションタイトル文字列取得
///
///  「タイトル」→「タイトル：」に変換する
/// - Parameter title: セクション名
/// - Returns: セクションタイトル文字列
func getSectionTitleText(_ title: String) -> String {
    return "\(title):"
}


// ========================================
// メンバ値の定義
// ========================================
/// メンバ値種別
enum memberType: String {
    /// メンバ値をランダムに指定
    case randomMemberId = "RANDOM_MEMBER_ID"
    /// 直前に使われたメンバ値を指定（ランダム指定直後に使うことを想定）
    case lastMemberId = "LAST_MEMBER_ID"
    /// 非メンバ値を指定
    case nonMemberId = "NON_MEMBER_ID"
    /// プッシュメンバ値を指定
    case pushMemberId = "PUSH_MEMBER_ID"
}


/// メンバ値変換
/// - Parameter memberId: 元メンバ値
/// - Returns: 変換メンバ値
func convertMemberId(_ memberId: String) -> String {
    switch memberId {
    // ランダム値
    case memberType.randomMemberId.rawValue:
        return String(format: "%07d", Int.random(in: 1 ... 9999999))
    // 前回のメンバ値
    case memberType.lastMemberId.rawValue:
        return UserDefaultsConfig.lastMemberId
    // PUSH用メンバ値
    case memberType.pushMemberId.rawValue:
        return UserDefaultsConfig.pushMemberId
    // その他のメンバ値
    default:
        return memberId
    }
}



// ========================================
// 特殊名称の定義
// ========================================


// ========================================
// その他
// ========================================
/// 改行文字コード
let SwiftLf = "\n"



// ========================================
// 開発環境
// ========================================
// Push用設定
let PUSH_SUB_DOMAIN_DEV = "mynd-push-sample"
let PUSH_APP_HASH_DEV = "5wqs8g1LF3hcQV3RvLRxaTYMCTT7oYYt"



// ========================================
// 本番環境
// ========================================
// Push用設定
let PUSH_SUB_DOMAIN_PRO = PUSH_SUB_DOMAIN_DEV
let PUSH_APP_HASH_PRO = PUSH_APP_HASH_DEV





//// 任意の返却値
let ANY_VALUE = "ANY_VALUE";

/// 効果測定IDをアプリキーに追加する際のキー
let SESSION_ID_KEY = "_rt.sid";

//// トラッキング成功メッセージ
//let SUCCESS_MESSAGE = "Track request was sent successfully.";
//
//// ナビゲーションバーの戻るボタンタイトル
//let BACK_BUTTON_TITLE = "";
//
// テスト実行時の同期用待ち時間（秒）と最大回数（タイムアウトを30秒として 30/SLEEP_TIME_TEST）
let SLEEP_TIME_TEST: Double = 0.1;
let SLEEP_MAX_COUNT: Int = 300;
//
//// 一度にテストの待ち時間（秒）
//let SLEEP_TIME_TEST_ALL: Double = 0.5;
//
//// ダミーのトラッキング送信後の待ち時間
//let SLEEP_TIME_DUMMY_TRACK: Double = 3.0;
//
//// Password using switch user RTSDK
//let PASSWORD_SWITCH_SERVER_RTSDK = "Fansipan";
//
//let TEST_CASE_FOLDER = "testcase";

// ========================================
// 既定値設定
// ========================================
/// 既定テストケースファイル名(拡張子なし)
let DEFAULT_TEST_CASE_FILE = "test_cases_v4_3"


// ========================================
// 受信リスト名
// ========================================
let RECOMMEND_RESPONSE_LIST_SECTION = "recommendResponseList"
let RECOMMEND_RESPONSE_LIST_ITEM_CONTENTS = "contents"
let RECOMMEND_RESPONSE_LIST_ITEM_SESSION_ID = "sessionId"



// ========================================
// 画面タイトル名
// ========================================
/// 設定画面タイトル
let SETTING_VIEW_TITLE = "設定"
/// テスト履歴画面タイトル
let TESTHISTORY_VIEW_TITLE = "テスト履歴"
/// テスト結果画面タイトル
let TESTRESULT_VIEW_TITLE = "テスト結果"



// ========================================
// テストケースファイルリスト
// MARK: このままではファイル順が固定されてしまわないか？
// ========================================
/// テストケースファイルリスト(読み取り専用)
var testCaseFileList: [String] {
    var testCaseFiles: [String] = []
    let files = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: "")
    files?.forEach({ (url) in
        let fileName = url.deletingPathExtension().lastPathComponent
        // テストケースファイルを限定：フォルダ内に複数のjsonファイルが混在しているため
        if fileName.lowercased().prefix(9) == "test_case" {
            testCaseFiles.append(fileName)
        }
    })
    return testCaseFiles
}
