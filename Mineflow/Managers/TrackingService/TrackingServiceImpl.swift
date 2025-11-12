//
//  TrackingServiceImpl.swift
//  Mineflow
//
//  Created by evhn on 12.11.2025.
//

import AppTrackingTransparency

struct TrackingServiceImpl: TrackingService {
    
    func requestAuthorization() async {
        await ATTrackingManager.requestTrackingAuthorization()
    }
    
    
}
