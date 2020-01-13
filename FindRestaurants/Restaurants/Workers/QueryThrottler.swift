//
//  QueryThrottler.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/13/20.
//  Copyright © 2020 Personal. All rights reserved.
//

protocol QueryThrottling {
    func shouldPerformNewQuery(for zoom: Float) -> Bool
}

final class QueryThrottler: QueryThrottling {
    
    private var throttledZoom: Float!
    private let minZoom: Float
    private let maxZoom: Float
    
    init(minZoom: Float, maxZoom: Float) {
        self.minZoom = minZoom
        self.maxZoom = maxZoom
    }
    
    func shouldPerformNewQuery(for zoom: Float) -> Bool {
        if (throttledZoom == nil || abs(zoom - throttledZoom) > 0.5) && zoomInAllowedRange(zoom) {
            throttledZoom = zoom
            return true
        }        
        return false
    }
    
    private func zoomInAllowedRange(_ zoom: Float) -> Bool {
        return (zoom > minZoom) && (zoom < maxZoom)
    }
}
