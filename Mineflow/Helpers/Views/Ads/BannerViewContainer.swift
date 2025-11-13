//
//  BannerViewContainer.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import GoogleMobileAds
import SwiftUI
import UIKit


struct BannerViewContainer: UIViewRepresentable {
    typealias UIViewType = BannerView
    let adSize: AdSize
    
    init(_ adSize: AdSize) {
        self.adSize = adSize
    }
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = AppConstants.banneradKey
        banner.load(Request())
        banner.delegate = context.coordinator
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
    
    func makeCoordinator() -> BannerCoordinator {
        return BannerCoordinator(self)
    }
    
    class BannerCoordinator: NSObject, BannerViewDelegate {
        
        let parent: BannerViewContainer
        var retryTimer: Timer?
        init(_ parent: BannerViewContainer) {
            self.parent = parent
        }

        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            self.retryTimer?.invalidate()
            self.retryTimer = nil
            LoggerInfo.log("DID RECEIVE AD.")
        }
        
        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            self.retryTimer?.invalidate()
            
            self.retryTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                Task { @MainActor in
                    self.reloadAd(on: bannerView)
                }
            }
            
            LoggerInfo.log("FAILED TO RECEIVE AD: \(error.localizedDescription)")
            
        }
        
        private func reloadAd(on bannerView: BannerView) {
            LoggerInfo.log("Attempting ad reload after 5 seconds...")
            bannerView.load(Request())
        }
        

    }
}


struct BannerAdsView: View {
    var body: some View {

        ZStack {
            #if DEBUG
            Color.white
            #endif
            GeometryReader { geo in
                let adSize = currentOrientationAnchoredAdaptiveBanner(width: scaleWidth(geo.size.width - 40))

                BannerViewContainer(adSize)

            }
        }
        .frame(height: scaleHeight(50))
    }
}
