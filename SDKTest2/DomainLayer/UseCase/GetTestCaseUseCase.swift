//
//  GetTestCaseUseCase.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/21.
//

import RxSwift

struct GetTestCaseUseCase {
    
    private let useRepository: UserRepository
    
    init(useRepository: UserRepository) {
        self.useRepository = useRepository
    }
    
    func run() -> Single<String>{
        self.useRepository.getTestCase()
    }
}
