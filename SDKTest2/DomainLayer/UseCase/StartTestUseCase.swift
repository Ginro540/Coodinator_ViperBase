//
//  StartTestUseCase.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/06/04.
//

import Foundation
import RxSwift

struct StartTestUseCase {
    
    private let useRepository: UserRepository
    
    init(useRepository: UserRepository) {
        self.useRepository = useRepository
    }
    
    func run() -> Single<String>{
        self.useRepository.getTestCase()
    }
}
