//
//  TestCase_v4.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/20.
//

import Foundation

struct ReadJson: Codable {
    var testCases: [TestCaseV4]
}

struct TestCaseV4: Codable {
    enum ApiKind: String, Codable {
        case TRACK
        case EVENT
        case RECOMMEND
        case POPUPRECOMMEND
        case CLICK
        case EVENT_CLICK
        case CONVERSION
        case IDENTIFY
        case OPT_IN
        case OPT_OUT
        case TEST_ALL
        case IOS_RECOMMEND_COMPLETION_HANDLER_NIL
        case IOS_TRACK_COMPLETION_HANDLER_NIL
        case API_KIND_OUT_OF_ALL
        case TRACK_AND_PRESENT_POPUPRECOMMEND
        case ANDROID_RECOMMEND_LISTENER_NULL
    }

    enum ParamType: String, Codable {
        case EDITABLE
        case READ_ONLY
        case PARAM_TYPE_OUT_OF_ALL
    }
    
    var title: String?
    var apiKind: ApiKind?
    var testAllTarget: Bool?
    var testGroups:[String]?
    var testParameters: testParameters?
    var paramTypeAccountId: ParamType?
    var expectContents: ExpectContents?
    var debugMode: Bool?
    var error: Bool?
}
