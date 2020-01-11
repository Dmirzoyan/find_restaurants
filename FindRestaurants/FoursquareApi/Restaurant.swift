//
//  Restaurant.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

struct Restaurant: Codable {
    let id: String
    let name: String
    let location: Location
    let contact: Contact?
}

struct Location: Codable {
    let address: String
    let lat: Double
    let lng: Double
    let distance: Int
    let postalCode: String
    let city: String
    let country: String
}

struct Contact: Codable {
    let formattedPhone: String
}
