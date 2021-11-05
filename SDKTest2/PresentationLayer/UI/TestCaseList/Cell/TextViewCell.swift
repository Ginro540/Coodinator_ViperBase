//
//  TextViewCell.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/21.
//

import Foundation
import UIKit

class TextViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var allTestImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func set(index:IndexPath,testCaseV4:TestCaseV4){
        self.title.text = testCaseV4.title
        
        guard let flg = testCaseV4.testAllTarget else {
            allTestImage.isHidden = true
            return
        }
        if flg {
            allTestImage.isHidden = true
        } else {
            allTestImage.isHidden = false
        }
        
        
    }
    
}
