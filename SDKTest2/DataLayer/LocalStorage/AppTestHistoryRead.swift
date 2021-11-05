//
//  AppTestHistoriesRead.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/05/27.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import RxSwift

protocol AppTestHistoryRead {
    func getTestHistory() -> Single<[TestRecord]?>
}

struct AppTestHistoryReadImpl: AppTestHistoryRead {
    
    func getTestHistory() -> Single<[TestRecord]?> {
        return Single.create { observer in
            observer(.success(TestHistoryUtil.getTestHistoryData()))
            return Disposables.create()
        }
    }
}
