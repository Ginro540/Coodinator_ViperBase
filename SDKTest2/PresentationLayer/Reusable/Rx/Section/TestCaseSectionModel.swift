//
//  TestCaseSectionModel.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/06/18.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import RxDataSources

struct TestCaseSectionModel {
    var header: String
    var items: [TestCaseV4]
}

extension TestCaseSectionModel: SectionModelType {
    typealias Item = TestCaseV4

    init(original: TestCaseSectionModel, items: [TestCaseV4]) {
        self = original
        self.items = items
    }
}
