//
//  OnboardingState.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//

import SwiftUI

struct OnboardingModel {
    var title: String
    var subtitle: String
    var image: Image
    var buttonTitle: String
    
    init(title: String, subtitle: String, image: Image, buttonTitle: String) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.buttonTitle = buttonTitle
    }
    
    static let allCases: [OnboardingModel] = [
        OnboardingModel(title: "Title", subtitle: "Subtitle", image: Image(.appBimb), buttonTitle: "Continue"),
        OnboardingModel(title: "Title", subtitle: "Subtitle", image: Image(.appBimb), buttonTitle: "Continue"),
        OnboardingModel(title: "Title", subtitle: "Subtitle", image: Image(.appBimb), buttonTitle: "Continue"),


    ]
}

struct OnboardingState {
    var onboardingModels: [OnboardingModel]  = OnboardingModel.allCases
    var currentIndex: Int = 0
}
