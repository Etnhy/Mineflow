//
//  OnboardingReducer.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//

import Foundation

func onboardingReducer(state: inout OnboardingState?,action: OnboardingAction) -> Void {
    guard var newState = state else { return }
    switch action {
    case .completed:
        state = nil
        return
    case .next:
        newState.currentIndex = min(newState.onboardingModels.count + 1, newState.currentIndex + 1)
        state = newState
    }
    
}
