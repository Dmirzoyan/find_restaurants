//
//  RestaurantsQuery.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

//sourcery: mock
protocol RestaurantsQuerying {
    func restaurant(for coordinate: Coordinate) -> Restaurant?
    func newRestaurants(in list: [Restaurant]) -> [Restaurant]
}

final class RestaurantsQuery: RestaurantsQuerying {
    
    private let store: StorageAccessing
    
    init(store: StorageAccessing) {
        self.store = store
    }
    
    func restaurant(for coordinate: Coordinate) -> Restaurant? {
        return store.getRestaurants().first(
            where: { $0.location.lat == coordinate.latitude && $0.location.lng == coordinate.longitude }
        )
    }
    
    func newRestaurants(in list: [Restaurant]) -> [Restaurant] {
        let presentedRestaurants = store.getRestaurants()
        var newRestaurants: [Restaurant] = []
        
        list.forEach { (restaurant) in
            if !(presentedRestaurants.contains(where: { $0.id == restaurant.id })) {
                newRestaurants.append(restaurant)
            }
        }
        
        return newRestaurants
    }
}
