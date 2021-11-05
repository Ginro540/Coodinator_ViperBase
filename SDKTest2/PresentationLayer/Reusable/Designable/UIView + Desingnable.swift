//
//  UIView + Desingnable.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/06/04.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
