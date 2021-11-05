//
//  UIColorExtention.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/06/05.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation

extension UIColor {
    
    /// Hex (16進)文字列から色データに変換する
    /// - Parameters:
    ///   - hex: 色データHex (16進)文字列 (R, G, B) 2桁ずつ計6桁
    ///   - alpha: アルファ値 ※省略時は「1.0」
    ///   - defaultColor: 変換できなかった場合の既定色 ※省略時は「White」
    /// - Returns: UIColor
    class func fromHex ( hex: String, alpha: CGFloat = 1.0, default defaultColor: UIColor = UIColor.white ) -> UIColor {
        let string_ = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: string_ as String)
        var color: UInt64 = 0
        if scanner.scanHexInt64(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        } else {
            return defaultColor
        }
    }
}
