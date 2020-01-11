//
//  RestaurantsPresenter.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

protocol RestaurantsDisplaying {}

final class RestaurantsPresenter: RestaurantsPresenting {
    
    private let display: RestaurantsDisplaying?
    
    init(display: RestaurantsDisplaying) {
        self.display = display
    }
}
