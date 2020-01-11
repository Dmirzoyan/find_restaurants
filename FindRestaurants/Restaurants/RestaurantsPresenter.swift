//
//  RestaurantsPresenter.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol RestaurantsDisplaying {
    func display(_ restaurantLocations: [Coordinate])
    func display(_ viewState: RestaurantInfoViewState)
    func displayAlert(with message: String)
}

final class RestaurantsPresenter: RestaurantsPresenting {
    
    private let display: RestaurantsDisplaying?
    
    init(display: RestaurantsDisplaying) {
        self.display = display
    }
    
    func presentAlert(with message: String) {
        display?.displayAlert(with: message)
    }
    
    func present(_ restaurants: [Restaurant]) {
        display?.display(restaurants.map {
            return Coordinate(latitude: $0.location.lat, longitude: $0.location.lng)
        })
    }
    
    func present(_ restaurantInfo: Restaurant) {
        display?.display(RestaurantInfoViewState(
            name: restaurantInfo.name,
            distance: "\(String(Float(restaurantInfo.location.distance) / 1000))" + " km",
            address: restaurantInfo.location.address,
            city: "\(restaurantInfo.location.postalCode)" + "\(restaurantInfo.location.city)",
            country: restaurantInfo.location.country,
            contact: restaurantInfo.location.country)
        )
    }
}