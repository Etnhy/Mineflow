//
//  Fonts+Extension.swift
//  Mineflow
//
//  Created by evhn on 07.11.2025.
//

import SwiftUI

enum SofiSans: String {
    case thin100        = "SofiaSans-Thin"
    case extralight200  = "SofiaSans-ExtraLight"
    case light300       = "SofiaSans-Light"
    case regular400     = "SofiaSans-Regular"
    case medium500      = "SofiaSans-Medium"
    case semiBold600    = "SofiaSans-SemiBold"
    case bold700        = "SofiaSans-Bold"
    case black900       = "SofiaSans-Black"
}


extension Font {
    static func sofia(weight: SofiSans, size: CGFloat) -> Font {
        return Font.custom(weight.rawValue, fixedSize: size)

     }
}
