//
//  SystemInfo.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/06/08.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import Foundation

/// システム情報データ
struct SystemInfo {
    static var DeviceInfo: String {
        return "\(DeviceName)"
    }

    static var DeviceName: String {
        var size : Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        let code: String = String(cString: machine)

        if code.hasPrefix("iPod") {
            return "iPod touch (\(UIDevice.current.systemVersion)) with \(cpuType) architecture"
        }
        else if code.hasPrefix("iPhone") {
            return "iPhone (\(UIDevice.current.systemVersion)) with \(cpuType) architecture"
        }
        else if code.hasPrefix("iPad") {
            return "iPad (\(UIDevice.current.systemVersion)) with \(cpuType) architecture"
        }
        else {
            var simulatedDevice: String = ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] ?? "Unknown Device"
            let dictionary = ["(": "",")": "", "generation": "Gen."]
            simulatedDevice = dictionary.reduce(simulatedDevice) { $0.replacingOccurrences(of: $1.key, with: $1.value) }
            return "Simulator of \(simulatedDevice) (\(UIDevice.current.systemVersion)) with \(code) architecture"
        }
    }
    
    static var cpuType: String {
        var cpuMType: Int64 = 0;
        var length = MemoryLayout.size(ofValue: cpuMType)
        sysctlbyname("hw.cputype", &cpuMType, &length, nil, 0)

        cpuMType = cpuMType & CPU_ARCH_MASK

        switch cpuMType {
        case CPU_TYPE_VAX:
            return "VAX CPU"
        case CPU_TYPE_MC680x0:
            return "MC680x0"
        case CPU_TYPE_POWERPC, CPU_TYPE_MC98000:
            return "PowerPC"
        case CPU_TYPE_HPPA:
            return "HP-PA RISC"
        case CPU_TYPE_MC88000:
            return "MC88000"
        case CPU_TYPE_SPARC:
            return "SPARC"
        case CPU_TYPE_I860:
            return "I860"
        case CPU_TYPE_X86:
            return "x86"
        case CPU_TYPE_ARM:
            var cpuSType: Int64 = 0;
            sysctlbyname("hw.cpusubtype", &cpuSType, &length, nil, 0)
            switch cpuSType {
            case CPU_SUBTYPE_ARM_V4T:
                return "ARM V4T"
            case CPU_SUBTYPE_ARM_V5TEJ:
                return "ARM V5TEJ"
            case CPU_SUBTYPE_ARM_V6:
                return "ARM V6"
            case CPU_SUBTYPE_ARM_V6M:
                return "ARM V6M"
            case CPU_SUBTYPE_ARM_XSCALE:
                return "ARM XSCALE"
            case CPU_SUBTYPE_ARM_V7:
                return "ARM V7"
            case CPU_SUBTYPE_ARM_V7F:
                return "ARM V7F"
            case CPU_SUBTYPE_ARM_V7S:
                return "ARM V7S"
            case CPU_SUBTYPE_ARM_V7K:
                return "ARM V7K"
            case CPU_SUBTYPE_ARM_V7M:
                return "ARM V7M"
            case CPU_SUBTYPE_ARM_V7EM:
                return "ARM V7EM"
            case CPU_SUBTYPE_ARM_V8:
                return "ARM V8"
            case CPU_SUBTYPE_ARM_V8M:
                return "ARM V8M"
            case CPU_SUBTYPE_ARM64_V8:
                return "ARM64 V8"
            case CPU_SUBTYPE_ARM64E:
                return "ARM64E"
            default:
                return "Unknown ARM"
            }
        default:
            return "Unknown CPU"
        }
    }

    // CPU 種別定義
    private static let CPU_ARCH_MASK    : Int64 = 0xffff
    private static let CPU_TYPE_VAX     : Int64 = 1
    private static let CPU_TYPE_MC680x0 : Int64 = 6
    private static let CPU_TYPE_X86     : Int64 = 7
    private static let CPU_TYPE_Mx      : Int64 = -1
    private static let CPU_TYPE_MC98000 : Int64 = 10
    private static let CPU_TYPE_HPPA    : Int64 = 11
    private static let CPU_TYPE_ARM     : Int64 = 12
    private static let CPU_TYPE_MC88000 : Int64 = 13
    private static let CPU_TYPE_SPARC   : Int64 = 14
    private static let CPU_TYPE_I860    : Int64 = 15
    private static let CPU_TYPE_POWERPC : Int64 = 18
    // ARM
    private static let CPU_SUBTYPE_ARM_ALL      : Int64 = 0
    private static let CPU_SUBTYPE_ARM64_V8     : Int64 = 1
    private static let CPU_SUBTYPE_ARM64E       : Int64 = 2
    private static let CPU_SUBTYPE_ARM_V4T      : Int64 = 5
    private static let CPU_SUBTYPE_ARM_V6       : Int64 = 6
    private static let CPU_SUBTYPE_ARM_V5TEJ    : Int64 = 7
    private static let CPU_SUBTYPE_ARM_XSCALE   : Int64 = 8
    private static let CPU_SUBTYPE_ARM_V7       : Int64 = 9
    private static let CPU_SUBTYPE_ARM_V7F      : Int64 = 10
    private static let CPU_SUBTYPE_ARM_V7S      : Int64 = 11
    private static let CPU_SUBTYPE_ARM_V7K      : Int64 = 12
    private static let CPU_SUBTYPE_ARM_V8       : Int64 = 13
    private static let CPU_SUBTYPE_ARM_V6M      : Int64 = 14
    private static let CPU_SUBTYPE_ARM_V7M      : Int64 = 15
    private static let CPU_SUBTYPE_ARM_V7EM     : Int64 = 16
    private static let CPU_SUBTYPE_ARM_V8M      : Int64 = 17
}
