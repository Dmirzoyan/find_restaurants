//
//  MapOverlayOpacityQuery.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/13/20.
//  Copyright © 2020 Personal. All rights reserved.
//

protocol MapOverlayOpacityQuerying {
    func opacity(for zoom: Float) -> Float
}

final class MapOverlayOpacityQuery: MapOverlayOpacityQuerying {
    
    private let maxOpacity: Float
    private let minZoom: Float
    
    init(maxOpacity: Float, minZoom: Float) {
        self.maxOpacity = maxOpacity
        self.minZoom = minZoom
    }
    
    func opacity(for zoom: Float) -> Float {
        return zoom > minZoom ? maxOpacity : clip(value: maxOpacity - Float((minZoom - zoom) / 5), lowerBound: 0)
    }
    
    private func clip(value: Float, lowerBound: Float) -> Float {
        return value < lowerBound ? lowerBound : value
    }
}
