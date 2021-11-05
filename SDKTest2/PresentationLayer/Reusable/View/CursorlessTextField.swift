//
//  CursorlessTextField.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/06/02.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import UIKit

class CursorlessTextField: UITextField {

    // 入力カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    // 範囲選択カーソル非表示
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
//    override func selectionRects(for range: UITextRange) -> [Any] {
//        return []
//    }
    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

}
