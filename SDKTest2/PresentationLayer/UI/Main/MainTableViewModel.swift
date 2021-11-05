//
//  MainTableViewModel.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/21.
//

import Foundation
import RxSwift
import RxCocoa

final class MainTableViewModel: ViewModelType{
    // 一括テスト
    private var allTest:[TestCaseV4] = []
    
    struct Input {
        let trigger: Driver<Void>
        let startAllTest: Observable<Void>
    }
    
    struct Output {
        let testJson : Driver<[MainTableSectionModel]>
        let test : Driver<Void>
    }
    
    private var fileReadUseCase:FileReadUseCase
    private var allTestUseCase:AlltestUseCase
    
    init(fileReadUseCase:FileReadUseCase,
         allTestUseCase:AlltestUseCase) {
        self.fileReadUseCase = fileReadUseCase
        self.allTestUseCase = allTestUseCase
    }
    
    func transform(input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let json = input.trigger
            .asObservable()
            .flatMapLatest {
                self.fileReadUseCase.run()
            }
            .map { self.createSections(items: $0) }
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        
        
        let test = input.startAllTest
            .asObservable()
            .flatMapLatest {
                self.allTestUseCase.run(testData: self.allTest, accountId: UserDefaultsConfig.accountId)
            }
            .map { _ in}
            .asDriver(onErrorJustReturn:())
        
        
        return Output(testJson: json, test: test)
    }
    
    private func createSections(items: TestTableJsonData)-> [MainTableSectionModel] {
      
        var sections:[MainTableSectionModel] = []
        var testItems: [testSectionItem] = []
        guard let groupItems = items.test_groups,
                 !groupItems.isEmpty,
                 let testItem  = items.testCases,
                 !testItem.isEmpty else {
            return sections
        }
        testItems.append(.allTest(title: ""))
        // 一括テストの一覧を取得
        for item in testItem {
            if !(item.testAllTarget ?? true){
                self.allTest.append(item)
            }
        }
        for group in groupItems {
            var testCases: [TestCaseV4] = []
            for (index,testCase) in testItem.enumerated() {
                if testCase.testGroups?.filter({ $0 == group.group_id}).first != nil {
                    testCases.append(testItem[index])
                }
            }
            testItems.append(.header(title: group.name ?? "", testCaseV4s: testCases))
        }
        sections.append(.testFile(items: testItems))
        return sections
    }
}
