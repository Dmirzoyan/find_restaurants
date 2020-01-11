//
//  RestaurantsInteractor.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol RestaurantsPresenting {}

final class RestaurantsInteractor: RestaurantsInteracting {
    
    private let router: RestaurantsInternalRoute
    private let presenter: RestaurantsPresenting
    
    init(
        router: RestaurantsInternalRoute,
        presenter: RestaurantsPresenting
    ) {
        self.router = router
        self.presenter = presenter
    }
}
