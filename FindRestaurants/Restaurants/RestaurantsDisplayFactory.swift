//
//  RestaurantsDisplayFactory.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import GoogleMaps

protocol RestaurantsDisplayProducing {
    func make(router: RestaurantsInternalRoute) -> UIViewController
}

final class RestaurantsDisplayFactory: RestaurantsDisplayProducing {
    
    func make(router: RestaurantsInternalRoute) -> UIViewController {
        let viewController = RestaurantsViewController()
        let presenter = RestaurantsPresenter(display: viewController)
        let store = StorageManager()
        
        let interactor = RestaurantsInteractor(
            router: router,
            presenter: presenter,
            restaurantsApiClient: FoursquareApiClient(),
            storageManager: store,
            restaurantsLimitQuery: RestaurantsLimitQuery(
                minZoom: 13,
                maxZoom: 16,
                minLimit: 4,
                maxLimit: 15
            ),
            restaurantsQuery: RestaurantsQuery(store: store)
        )
        
        viewController.interactor = interactor
        viewController.locationManager = CLLocationManager()
        
        return viewController
    }
}
