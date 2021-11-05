//
//  EnvSetting.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/30.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation

struct EnvSettingJson: Codable {
    var env_settings: [EnvSetting]
}

/// 接続環境
struct EnvSetting: Codable {
    /// 接続環境ID
    var env_id: String?
    /// 接続環境名(タイトル表示用)
    var name: String?
    /// インデックス(ソート用)
    var index: Int?
    /// 接続環境URL
    var url: String?
    /// 接続環境色(タイトル背景色用)
    var color: String?
}
