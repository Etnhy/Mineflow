//
//  Logger.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import Foundation

final class LoggerInfo {
    static func log(_ message: Any) {
#if DEBUG
        print("[Mineflow] \(message)")
#endif
    }
}
