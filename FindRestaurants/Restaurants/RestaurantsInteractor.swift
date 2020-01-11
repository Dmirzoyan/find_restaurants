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
    func presentAlert(with message: String)
}

final class RestaurantsInteractor: RestaurantsInteracting {
    
    private let router: RestaurantsInternalRoute
    private let presenter: RestaurantsPresenting
    private let restaurantsApiClient: RestaurantsApiAccessing
    
    init(
        router: RestaurantsInternalRoute,
        presenter: RestaurantsPresenting,
        restaurantsApiClient: RestaurantsApiAccessing
    ) {
        self.router = router
        self.presenter = presenter
        self.restaurantsApiClient = restaurantsApiClient
    }
    
    func findRestaurants(for coordinate: Coordinate, radius: Int, limit: Int) {
        restaurantsApiClient.findRestaurants(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            radius: radius,
            limit: limit
        ) { [weak self] (restaurants, error) in
            guard
                error == nil,
                let strongSelf = self
            else {
                self?.presenter.presentAlert(with: "Could not retrieve restaurants")
                return
            }
            
            strongSelf.presenter.present(restaurants)
        }
    }
}
