//
//  Injection.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

class Injection {
    
    static func makeAssembler() -> StartupAssembler {
        return StartupAssemblerImpl()
    }
    static func makeAssembler() -> MainTableAssembler {
        return MainTableAssemblerImpl()
    }
    static func makeAssembler() -> TestHistoryAssembler {
        return TestHistoryAssemblerImpl()
    }
    static func makeAssembler() -> SettingAssembler {
        return SettingAssemblerImpl()
    }
}
