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
            subtitle: "Tap tiles to open the board. Numbers show how many nearby hints surround each tile.",
            image: Image(.firstField),
            buttonTitle: "Next Step"
        ),
        
        OnboardingModel(
            title: "Master the Mark",
            subtitle: "Long-press to place a marker on any tile you want to keep track of. Use markers to plan your strategy.",
            image: Image(.secondField),
            buttonTitle: "View Strategy"
        ),
        
        OnboardingModel(
            title: "Ready for Mineflow?",
            subtitle: "Every board is a pure logic puzzle. The timer starts on your first tap. Stay focused and enjoy the flow.!",
            image: Image(.thirdField),
            buttonTitle: "Let's Play!" 
        ),
    ]
}
