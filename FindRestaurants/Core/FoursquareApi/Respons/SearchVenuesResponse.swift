//
//  SearchVenuesResponse.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

struct SearchVenuesResponse: Codable {
    let meta: Meta
    let response: VenuesResponse
}

struct VenuesResponse: Codable {
    let venues: [Venue]
}
