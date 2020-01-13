//
//  RestaurantsLimitQuery.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

protocol RestaurantsLimitQuerying {
    func limit(for zoom: Float) -> Int
}

final class RestaurantsLimitQuery: RestaurantsLimitQuerying {
    
    private let minZoom: Float
    private let maxZoom: Float
    private let minLimit: Int
    private let maxLimit: Int
    
    init(minZoom: Float, maxZoom: Float, minLimit: Int, maxLimit: Int) {
        self.minZoom = minZoom
        self.maxZoom = maxZoom
        self.minLimit = minLimit
        self.maxLimit = maxLimit
    }
    
    func limit(for zoom: Float) -> Int {
        if zoom < minZoom {
            return minLimit
        } else if zoom > maxZoom {
            return maxLimit
        } else {
            return Int((zoom - minZoom) * 3) + 4
        }
    }
}
