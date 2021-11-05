//
//  ObservableType.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/22.
//
import RxSwift
import RxCocoa
extension ObservableType {
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
  }

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
}

