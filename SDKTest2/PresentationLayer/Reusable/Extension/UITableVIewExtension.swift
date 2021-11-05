//
//  TableVIewExtension.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/21.
//

import UIKit

extension UITableViewDelegate {

    func registerCell(_ tableView: UITableView) {
        tableView.register(UINib(nibName: R.nib.textViewCell.name, bundle: nil),
            forCellReuseIdentifier: R.nib.textViewCell.identifier)
        
        tableView.register(UINib(nibName: R.nib.headerCell.name, bundle: nil),
            forCellReuseIdentifier: R.nib.headerCell.identifier)
    }
    
    
    

}
