//
//  View+Extensions.swift
//  Mineflow
//
//  Created by evhn on 07.11.2025.
//

import SwiftUI

let isSmallDevice: Bool = UIScreen.main.bounds.height < 736

fileprivate let screenSize = UIScreen.main.bounds.size

fileprivate let BASE_HEIGHT: CGFloat = 812.0

fileprivate let BASE_WIDTH: CGFloat = 375.0

extension View {
    func scaleHeight(_ height: CGFloat) -> CGFloat {
       return (height / BASE_HEIGHT) * screenSize.height 
    }
    
    func scaleWidth(_ width: CGFloat) -> CGFloat {
        return (width / BASE_WIDTH) * screenSize.width
    }
}
