//
//  OnboardingModel.swift
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
        OnboardingModel(
            title: "Uncover the Flow",
            subtitle: "Tap cells to reveal safe areas. Numbers show exactly how many bombs touch that square.",
            image: Image(.firstField),
            buttonTitle: "Next Step"
        ),
        
        OnboardingModel(
            title: "Master the Mark",
            subtitle: "Long-press a cell to place a flag (🚩) on a suspected mine. Mark your path to avoid failure.",
            image: Image(.appBimb),
            buttonTitle: "View Strategy"
        ),
        
        OnboardingModel(
            title: "Ready for Mineflow?",
            subtitle: "Every challenge is solvable by logic. The timer starts on your first tap. Good luck!",
            image: Image(.appBimb),
            buttonTitle: "Let's Play!" 
        ),
    ]
}
