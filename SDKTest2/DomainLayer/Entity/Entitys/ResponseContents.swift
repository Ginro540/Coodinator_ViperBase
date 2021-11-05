//
//  ReceivedContents.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/06/05.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation

/// 受信コンテンツ
struct ResponseContents: Codable {
    /// 受信結果データ
    var responseDatas: [String: String]?
    /// 受信結果リストデータ
    var responseLists: [String: [[String:String]]]?
}
