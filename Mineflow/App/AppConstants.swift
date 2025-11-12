//
//  AppConstants.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import Foundation

enum AppConstants {
    static let appleID = "6754763884"
    static let shareLink = "https://apps.apple.com/app/id\(Self.appleID)"
    
    static let privacyLink = "https://sites.google.com/view/mineflow/privacy-policy"
    static let termsLink = "https://sites.google.com/view/mineflow/terms-of-use"
    
    static let supportMail = "appdev8661@gmail.com"
    
    static let feedbackLink = "mailto:\(Self.supportMail)?subject=Mineflow"
    
    
    #if DEBUG
    static let banneradKey = "ca-app-pub-3940256099942544/2435281174"
//    static let rewardAdKey = "ca-app-pub-3940256099942544/2435281174"
    #else
    static let banneradKey = "ca-app-pub-2903076569215801/7817750617"
//    static let rewardAdKey = "ca-app-pub-2903076569215801/2971660181"

    #endif
    
}
