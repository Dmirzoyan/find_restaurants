//
//  RestaurantsRouter.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol RestaurantsRoute {
    func start()
}

protocol RestaurantsInternalRoute {}

final class RestaurantsRouter: RestaurantsRoute {
    
    private let navigationController: UINavigationController
    private let displayFactory: RestaurantsDisplayProducing
    
    init(
        navigationController: UINavigationController,
        displayFactory: RestaurantsDisplayProducing
    ) {
        self.navigationController = navigationController
        self.displayFactory =  displayFactory
    }
    
    func start() {
        let viewController = displayFactory.make(router: self)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension RestaurantsRouter: RestaurantsInternalRoute {}
