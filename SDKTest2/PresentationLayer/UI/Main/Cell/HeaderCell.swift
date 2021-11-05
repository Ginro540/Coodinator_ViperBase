//
//  HeaderCell.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/06/03.
//

import Foundation

class HeaderCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func set(index:IndexPath,title:String){
        self.title.text = title
    }
    
}
