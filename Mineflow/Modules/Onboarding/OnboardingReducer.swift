//
//  OnboardingReducer.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//

import Foundation

func onboardingReducer(state: inout OnboardingState?,action: OnboardingAction) {
    switch action {
    case .completed:
        state = nil
    }
}
