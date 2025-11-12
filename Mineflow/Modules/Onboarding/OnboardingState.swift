//
//  OnboardingState.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//

import SwiftUI


struct OnboardingState {
    var onboardingModels: [OnboardingModel]  = OnboardingModel.allCases
    var currentIndex: Int = 0
}
