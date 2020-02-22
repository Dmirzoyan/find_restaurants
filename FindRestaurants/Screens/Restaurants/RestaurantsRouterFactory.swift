//
//  RestaurantsRouterFactory.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol RestaurantsRouterProducing {
    func make() -> RestaurantsRoute
}

final class RestaurantsRouterFactory: RestaurantsRouterProducing {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func make() -> RestaurantsRoute {
        return RestaurantsRouter(
            navigationController: navigationController,
            displayFactory: RestaurantsDisplayFactory()
        )
    }
}
