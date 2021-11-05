//
//  TestParamater.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import Foundation

/// テストパラメータ
struct testParameters: Codable {
    /// メンバ値
    var memberId: String?
    ///ホスト名
    var hostName: String?
    /// ロケーション
    var location: String?
    /// リファラ
    var referrer: String?
    /// ユーザーエージェント
    var userAgent: String?
    /// IP アドレス
    var ipAddress: String?
    /// エレメントID (複数可)
    var elementIds: [String]?
    /// アプリキー (複数可)
    var appKeys: [String:String]?
    /// レコメンドアプリキー (複数可)
    var recommendAppKeys: [String:String]?
    
}
