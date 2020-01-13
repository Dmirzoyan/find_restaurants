//
//  RestaurantsInteractor.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol RestaurantsPresenting {
    func present(_ restaurants: [Restaurant])
    func present(_ restaurantInfo: Restaurant)
    func presentAlert(with message: String)
}

final class RestaurantsInteractor: RestaurantsInteracting {
    
    private let router: RestaurantsInternalRoute
    private let presenter: RestaurantsPresenting
    private let restaurantsApiClient: RestaurantsApiAccessing
    private let storageManager: StorageManaging
    private let restaurantsLimitQuery: RestaurantsLimitQuerying
    private let restaurantsQuery: RestaurantsQuerying
    
    init(
        router: RestaurantsInternalRoute,
        presenter: RestaurantsPresenting,
        restaurantsApiClient: RestaurantsApiAccessing,
        storageManager: StorageManaging,
        restaurantsLimitQuery: RestaurantsLimitQuerying,
        restaurantsQuery: RestaurantsQuerying
    ) {
        self.router = router
        self.presenter = presenter
        self.restaurantsApiClient = restaurantsApiClient
        self.storageManager = storageManager
        self.restaurantsLimitQuery = restaurantsLimitQuery
        self.restaurantsQuery = restaurantsQuery
    }
    
    func findRestaurants(for coordinate: Coordinate, zoom: Float) {
        restaurantsApiClient.findRestaurants(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            radius: 4000,
            limit: restaurantsLimitQuery.limit(for: zoom)
        ) { [weak self] (restaurants, error) in
            guard
                error == nil,
                let strongSelf = self
            else {
                self?.presenter.presentAlert(with: "Could not retrieve restaurants")
                return
            }
            
            let newRestaurants = strongSelf.restaurantsQuery.newRestaurants(in: restaurants)
            strongSelf.storageManager.add(restaurants: restaurants)
            strongSelf.presenter.present(newRestaurants)
        }
    }
    
    func viewRestaurantInfo(for coordinate: Coordinate) {
        if let restaurant = restaurantsQuery.restaurant(for: coordinate) {
            
            if let _ = restaurant.details {
                presenter.present(restaurant)
            } else {
                restaurantsApiClient.getRestaurantDetails(restaurantId: restaurant.id) {
                    [weak self] (restaurantDetails, error) in
                    guard
                        error == nil,
                        let restaurantDetails = restaurantDetails,
                        let strongSelf = self
                    else {
                        self?.presenter.presentAlert(with: "Could not retrieve restaurant info")
                        return
                    }
                    
                    strongSelf.storageManager.addRestaurantDetails(
                        restaurantId: restaurant.id,
                        details: restaurantDetails
                    )
                    strongSelf.presenter.present(restaurant)
                }
            }
        }
    }
}
