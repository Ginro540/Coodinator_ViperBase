//
//  AlltestUseCase.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/06/06.
//

import Foundation
import RxSwift

struct AlltestUseCase {
    
    private let useRepository: UserRepository
    
    init(useRepository: UserRepository) {
        self.useRepository = useRepository
    }
    
    func run(testData:[TestCaseV4],accountId: String) -> Single<Void>{
        self.useRepository.allTestStart(testData: testData, accountId: accountId)
    }
}
