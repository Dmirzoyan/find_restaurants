//
//  GetVenueDetailsResponse.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

struct GetVenueDetailsResponse: Codable {
    let meta: Meta
    let response: VenueDetailsResponse
}

struct VenueDetailsResponse: Codable {
    let venue: Venue?
}
