//
//  RtaAccount.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/30.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation

struct RtaAccountsJson: Codable {
    var rta_accounts: [RtaAccount]
}

/// RTA アカウント
struct RtaAccount: Codable {
    /// アカウントID
    var account_id: String?
    /// 関連接続環境
    var envs: [String]?
    /// ユーザー名
    var user_name: String?
    /// パスワード
    var password: String?
    /// 説明 (アプリ未使用)
    var desc: String?
}
