//
//  TestGroups.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/06/03.
//

import Foundation
struct TestGroups: Codable {
    var test_groups: [testItem]?
}

struct testItem: Codable {
    var group_id: String?
    var name: String?
}
