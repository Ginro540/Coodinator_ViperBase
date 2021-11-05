//
//  GetInitSettingJsonUseCase.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/06/02.
//

import RxSwift

struct GetInitSettingJsonUseCase {
    
    private let useRepository: UserRepository
    
    init(useRepository: UserRepository) {
        self.useRepository = useRepository
    }
    
    func run() -> Single<Void>{
        Single.zip(self.useRepository.getEnvSettingFileRead(),
                   self.useRepository.getRtaAccountFileRead())
            .map{( envSettings, rAccounts) in
                    guard let env = envSettings,
                          !env.isEmpty,
                          let rt  = rAccounts,
                          !rt.isEmpty  else {
                        return
                    }
                    setUserDefault(envSettings: env, rtaAccounts: rt)
            }
    }
    
    /// データを格納
    private func setUserDefault(envSettings: [EnvSetting], rtaAccounts: [RtaAccount]) {
        
        if !UserDefaultsConfig.testCaseFileName.isEmpty {
            return
        }

        // 既定テストケースファイル名
        UserDefaultsConfig.testCaseFileName = DEFAULT_TEST_CASE_FILE
        
        /// 環境設定初期値
        let firstEnvSetting = envSettings.first(where: { $0.index == 0 }) ?? envSettings.first
        let envId = firstEnvSetting?.env_id ?? ""
        UserDefaultsConfig.envId = envId
        UserDefaultsConfig.envName = firstEnvSetting?.name ?? ""
        UserDefaultsConfig.envUrl = firstEnvSetting?.url ?? ""
        UserDefaultsConfig.envColor = firstEnvSetting?.color ?? ""
        
        /// 環境設定初期値
        let firstRtaAccount = rtaAccounts.first(where: { $0.envs?.contains(envId) ?? false }) ?? rtaAccounts.first
        UserDefaultsConfig.accountId = firstRtaAccount?.account_id ?? ""
        UserDefaultsConfig.userName = firstRtaAccount?.user_name ?? ""
        UserDefaultsConfig.password = firstRtaAccount?.password ?? ""
    }
}
