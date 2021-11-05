//
//  PaddingLabel.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/27.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {

    var padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: padding)
        super.drawText(in: newRect)
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }

}
