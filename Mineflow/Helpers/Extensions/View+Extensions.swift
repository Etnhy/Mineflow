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
        if isSmallDevice {
            return height
        } else {
            return (height / BASE_HEIGHT) * screenSize.height

        }
    }
    
    func scaleWidth(_ width: CGFloat) -> CGFloat {
        if isSmallDevice {
            return width
        } else {
            
            return (width / BASE_WIDTH) * screenSize.width
        }
    }
    
    func multipleWidth(_ multiple: CGFloat) -> CGFloat {
        return screenSize.width * multiple
    }
    
    func multipleHeight(_ multiple: CGFloat) -> CGFloat {
        return screenSize.height * multiple
    }
}
