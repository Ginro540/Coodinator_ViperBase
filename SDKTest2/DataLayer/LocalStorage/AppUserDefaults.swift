//
//  AppUserDefaults.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/21.
//

import RxSwift

protocol AppUserDefaults {
    func getTestCase() -> Single<String>
    func getUserName() -> Single<String>
    func getPassword() -> Single<String>
}

struct AppUserDefaultsImpl:AppUserDefaults {
    
    func getTestCase() -> Single<String> {
        return Single.create { observer in
            observer(.success(UserDefaultsUtil.getTeatCase(key: UserDefaultsKey.testCaseFileNameKey)))
            return Disposables.create()
        }
    }

    func getUserName() -> Single<String> {
        return Single.create { observer in
            observer(.success(UserDefaultsUtil.getStringValue(key: UserDefaultsKeys.USER_NAME_KEY.rawValue)))
            return Disposables.create()
        }
    }

    func getPassword() -> Single<String> {
        return Single.create { observer in
            observer(.success(UserDefaultsUtil.getStringValue(key: UserDefaultsKeys.PASSWORD_KEY.rawValue)))
            return Disposables.create()
        }
    }

}

private struct UserDefaultsKey {
    static let testCaseFileNameKey = "testCaseFileName";
}

private enum UserDefaultsKeys: String {
    case USER_NAME_KEY = "userName"
    case PASSWORD_KEY = "password"
    case PUSH_MEMBER_ID_KEY = "pushMemberId"
    case LAST_MEMBER_ID_KEY = "lastMemberId"
    case LAST_SESSION_ID_KEY = "lastSessionId"
    case TEST_CASE_FILE_NAME_KEY = "testCaseFileName"
    case SERVER_RTSDK_KEY = "serverRTSDK"
    case NEW_ENVIRONMENT_KEY = "newEnvironment"
    case USE_QUEUE_OBSERVER = "useQueueObserver"
}

