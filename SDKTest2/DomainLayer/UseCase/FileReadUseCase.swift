//
//  FileReadUseCase.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import RxSwift

struct FileReadUseCase {
    
    private let useRepository: UserRepository
    
    init(useRepository: UserRepository) {
        self.useRepository = useRepository
    }
    
    func run() -> Single<TestTableJsonData>{
        Single.zip(
            self.useRepository.getFileRead(),
            self.useRepository.getTestGroupFileRead())
        .map { (testData, groupDate) in
                    
            var data = TestTableJsonData()
            data.testCases = testData
            data.test_groups = groupDate
            return data
        }

    }

    
}
