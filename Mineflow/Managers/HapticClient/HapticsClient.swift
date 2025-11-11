//
//  HapticsClient.swift
//  Mineflow
//
//  Created by evhn on 31.10.2025.
//


import UIKit



struct HapticsClient {
    var play: (UIImpactFeedbackGenerator.FeedbackStyle) -> Void
    var notify: (UINotificationFeedbackGenerator.FeedbackType) -> Void
    
    static let live = HapticsClient(
        play: { style in
#if !targetEnvironment(simulator)
            UIImpactFeedbackGenerator(style: style).impactOccurred()
#endif
            print("notify: \(style)")

        },
        notify: { type in
#if !targetEnvironment(simulator)
            UINotificationFeedbackGenerator().notificationOccurred(type)
#endif
            print("notify: \(type)")
        }
    )
    
    static let noop = HapticsClient(play: { _ in }, notify: { _ in })
}


