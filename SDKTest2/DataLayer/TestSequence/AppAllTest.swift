//
//  AppAllTest.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/06/06.
//

import Foundation
import RxSwift
protocol AppAllTest {
    func allTestStart(testData:[TestCaseV4],accountId:String) -> Single<Void>
}

class AppAllTestImpl:AppAllTest {
    func allTestStart(testData: [TestCaseV4], accountId: String) -> Single<Void> {
        return Single.create { observer in
            observer(.success(AllTestSequence.allTestStart(testData: testData, accountId: accountId)))
            return Disposables.create()
        }
    }
}
