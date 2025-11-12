//
//  SplashReducer.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//

import Foundation

func splashReducer(state: inout SplashState?, action: SplashAction) {
    switch action {
    case .onAppear, .dataLoaded:
        break
    case .ended:
        state = nil
    }
}
