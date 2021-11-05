//
//  TestHistorySectionModel.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/27.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import RxDataSources

struct TestHistorySectionModel {
    var header: String
    var items: [TestRecord]
}

extension TestHistorySectionModel: SectionModelType {
    typealias Item = TestRecord

    init(original: TestHistorySectionModel, items: [TestRecord]) {
        self = original
        self.items = items
    }
}
