//
//  ViewModelType.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input:Input) -> Output
}
