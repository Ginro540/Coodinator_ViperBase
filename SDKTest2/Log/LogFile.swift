//
//  LogFile.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/06/03.
//

import Foundation
class LogFile {
    private static let file = "log.text"

    static func write(_ log: String) {
        writeToFile(file: file, text: log)
    }

    static func writeln(_ log: String) {
        writeToFile(file: file, text: "\(log)\n")
    }

    private static func writeToFile(file: String, text: String) {
        guard let documentPath =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask).first else { return }

        let path = documentPath.appendingPathComponent(file)
        _ = appendText(fileURL: path, text: text)
    }

    private static func appendText(fileURL: URL, text: String) -> Bool {
        guard let stream = OutputStream(url: fileURL, append: true) else { return false }
        stream.open()

        defer { stream.close() }

        guard let data = text.data(using: .utf8) else { return false }

        let result = data.withUnsafeBytes {
            stream.write($0, maxLength: data.count)
        }

        return (result > 0)
    }
    
    static func getFilePath() -> URL {
        let documentPath = FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask).first
        return documentPath!.appendingPathComponent(LogFile.file)
    }
}
