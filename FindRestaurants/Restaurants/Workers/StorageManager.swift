//
//  StorageManager.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol StorageManaging {
    func store(restaurants: [Restaurant])
    func restaurant(for coordinate: Coordinate) -> Restaurant?
    func addRestaurantDetails(restaurantId: String, details: RestaurantDetails)
}

final class StorageManager: StorageManaging {

    private var restaurants: [Restaurant] = []
    
    func store(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
    
    func restaurant(for coordinate: Coordinate) -> Restaurant? {
        return restaurants.first(
            where: { $0.location.lat == coordinate.latitude && $0.location.lng == coordinate.longitude }
        )
    }
    
    func addRestaurantDetails(restaurantId: String, details: RestaurantDetails) {
        if let restaurant = restaurants.first(where: { $0.id == restaurantId }) {
            restaurant.details = details
        }
    }
}
