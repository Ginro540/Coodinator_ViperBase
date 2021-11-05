//
//  SectionModelType.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/21.
//

import RxDataSources


enum MainTableSectionModel {
    case testFile(items: [testSectionItem])
}

extension MainTableSectionModel: AnimatableSectionModelType {

    
    init(original: MainTableSectionModel, items: [testSectionItem]) {
        switch original {
        case .testFile:
            self = .testFile(items: items)
        }
    }
    
    var identity: String {
        switch self {
        case .testFile:
            return "testFile"
        }
    }

    typealias Item = testSectionItem
    
    var items: [Item] {
        switch self {
        case let .testFile(items):
            return items.map { $0 }
        }
    }
}
enum testSectionItem {
    case header(title: String, testCaseV4s: [TestCaseV4])
    case allTest(title: String)
}
extension testSectionItem: IdentifiableType, Equatable {
    static func == (lhs: testSectionItem, rhs: testSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }
    
    var identity: String {
        switch self {
        case let .header(title: value, testCaseV4s: _):
            return value
            
        case .allTest( _):
            return ""
        }
}
}
