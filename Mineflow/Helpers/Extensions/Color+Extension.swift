//
//  Color+Extension.swift
//  Mineflow
//
//  Created by evhn on 13.11.2025.
//

import SwiftUI

extension Color {
    init(hex: String, alpha: Double? = nil) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        Scanner(string: hexString).scanUnsignedLongLong(&int)
        
        let r: UInt64
        let g: UInt64
        let b: UInt64
        let a: UInt64
        
        switch hexString.count {
        case 3:
            (r, g, b, a) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17, 255)
        case 4:
            (a, r, g, b) = ((int >> 12) * 17, (int >> 8 & 0xF) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8:
            (r, g, b, a) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF, int >> 24)
        default:
            (r, g, b, a) = (0, 0, 0, 255)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: alpha ?? Double(a) / 255
        )
    }
}
