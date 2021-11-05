//
//  TestResultSectionModel.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/23.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import RxDataSources

struct TestResultSectionModel {
    var header: String
    var items: [String]
}

extension TestResultSectionModel: SectionModelType {
    typealias Item = String

    init(original: TestResultSectionModel, items: [String]) {
        self = original
        self.items = items
    }
}
