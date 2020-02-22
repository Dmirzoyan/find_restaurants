//
//  StorageManager.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

//sourcery: mock
protocol StorageManaging {
    func add(restaurants: [Restaurant])
    func addRestaurantDetails(restaurantId: String, details: RestaurantDetails)
}

protocol StorageAccessing {    
    func getRestaurants() -> [Restaurant]
}

final class StorageManager: StorageManaging {

    private var restaurants: [Restaurant] = []
    
    func add(restaurants: [Restaurant]) {
        restaurants.forEach { (restaurant) in
            if !(self.restaurants.contains(where: { $0.id == restaurant.id })) {
                self.restaurants.append(restaurant)
            }
        }
    }
    
    func addRestaurantDetails(restaurantId: String, details: RestaurantDetails) {
        if let restaurant = restaurants.first(where: { $0.id == restaurantId }) {
            restaurant.details = details
        }
    }
}

extension StorageManager: StorageAccessing {
    
    func getRestaurants() -> [Restaurant] {
        return restaurants
    }
}
