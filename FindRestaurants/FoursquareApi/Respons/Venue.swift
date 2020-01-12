//
//  Venue.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

struct Venue: Codable {
    let id: String
    let name: String
    let location: Location
    let contact: Contact?
    let url: String?
    let photos: Photos?
}

struct Location: Codable {
    let address: String
    let lat: Double
    let lng: Double
    let distance: Int?
    let postalCode: String?
    let city: String
    let country: String
}

struct Contact: Codable {
    let formattedPhone: String?
}

struct Photos: Codable {
    let groups: [Group]
}

struct Group: Codable {
    let items: [Item]
}

struct Item: Codable {
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
}
