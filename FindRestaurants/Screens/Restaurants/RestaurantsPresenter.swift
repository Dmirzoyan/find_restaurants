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
    func displayOverlay(with opacity: CGFloat)
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
    
    func present(restaurants: [Restaurant]) {
        display?.display(
            restaurants.map {
                return Coordinate(latitude: $0.location.lat, longitude: $0.location.lng)
        })
    }
    
    func present(restaurantInfo: Restaurant) {        
        display?.display(
            RestaurantInfoViewState(
                name: restaurantInfo.name,
                distance: {
                    guard let distance = restaurantInfo.location.distance
                    else {
                        return ""
                    }
                    return "Distance - \(String(Float(distance) / 1000))" + " km"
                }(),
                street: restaurantInfo.location.address,
                city: "\(restaurantInfo.location.postalCode ?? "")" + "\(restaurantInfo.location.city)",
                country: restaurantInfo.location.country,
                phone: restaurantInfo.details?.phone,
                image: {
                    guard
                        let url = restaurantInfo.details?.photos.first?.imageUrl(),
                        let imageData = try? Data(contentsOf: url as URL)
                    else { return nil }
                        
                    return UIImage(data: imageData)
                }(),
                url: restaurantInfo.details?.url
            )
        )
    }
    
    func presentOverlay(with opacity: Float) {
        display?.displayOverlay(with: CGFloat(opacity))
    }
}
