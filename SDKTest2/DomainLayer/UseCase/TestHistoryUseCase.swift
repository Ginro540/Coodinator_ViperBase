//
//  GetTestHistoriesUseCase.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/27.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import RxSwift

struct TestHistoryUseCase {
    
    private let useRepository: UserRepository
    
    init(useRepository: UserRepository) {
        self.useRepository = useRepository
    }
    
    func run() -> Single<[TestRecord]?>{
        self.useRepository.getTestHistory()
    }
}
