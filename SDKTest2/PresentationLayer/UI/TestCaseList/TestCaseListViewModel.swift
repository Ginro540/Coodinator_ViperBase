//
//  TestCaseListViewModel.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/06/18.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// テストケース選択画面ViewModel
final class TestCaseListViewModel {

    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let testJson : Driver<[TestCaseSectionModel]>
    }

    private var testCaseGroupTitle: String
    private var testCaseV4s: [TestCaseV4]!
    
    // ----------------------------------------
    /// 初期化処理
    /// - Parameter testCaseGroupTitle: テストケースグループ名
    /// - Parameter testCases: テストケースリスト
    init(testCaseGroupTitle: String, testCases: [TestCaseV4]) {
        self.testCaseGroupTitle = testCaseGroupTitle
        self.testCaseV4s = testCases
    }
    
    func transform(input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let json = input.trigger
            .asObservable()
            .map { self.createSections(header: self.testCaseGroupTitle, items: self.testCaseV4s) }
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()

        return Output(testJson: json)
    }

    /// テスト履歴から表示用データを生成する
    /// - Parameter item: テストケースリスト
    /// - Returns: TestCaseSectionModelリスト
    private func createSections(header: String, items: [TestCaseV4]?) -> [TestCaseSectionModel] {
        var sections: [TestCaseSectionModel] = []
        guard let testCases = items else {
            return sections
        }
        var items: [TestCaseV4] = []
        for testCase in testCases {
            items.append(testCase)
        }
        sections.append(TestCaseSectionModel(header: header, items: items))
        return sections
    }
}
