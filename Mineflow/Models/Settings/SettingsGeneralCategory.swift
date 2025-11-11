//
//  SettingsGeneralCategory.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//


enum SettingsGeneralCategory: Int,CaseIterable {
    case feedback,share, privacy,terms
    
    var title: String {
        switch self {
        case .privacy: return "Privacy Policy"
        case .terms: return "Terms of Service"
        case .share: return "Share"
        case .feedback: return "Feedback"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .feedback:
            return "буду рад вашему отзыву"
        default: return nil
        }
    }
}