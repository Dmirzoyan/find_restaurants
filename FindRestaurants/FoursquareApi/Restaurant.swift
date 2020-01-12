//
//  Restaurant.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

final class Restaurant {
    
    let id: String
    let name: String
    let location: Location
    var details: RestaurantDetails?
    
    init(id: String, name: String, location: Location, details: RestaurantDetails? = nil) {
        self.id = id
        self.name = name
        self.location = location
        self.details = details
    }
}

final class RestaurantDetails {
    
    let url: String?
    let phone: String?
    let photos: [RestaurantPhotoInfo]
    
    init(url: String?, phone: String?, photos: [RestaurantPhotoInfo]) {
        self.url = url
        self.photos = photos
        self.phone = phone
    }
    
}

final class RestaurantPhotoInfo {
    private let prefix: String
    private let suffix: String
    private let width: Int
    private let height: Int
    
    init(prefix: String, suffix: String, width: Int, height: Int) {
        self.prefix = prefix
        self.suffix = suffix
        self.width = width
        self.height = height
    }
    
    func imageUrl(for maxImgWidth: Int = 700) -> URL? {
        let size = width > maxImgWidth ? maxImgWidth : width
        return URL(string: "\(prefix)\(size)x\(size / 2)\(suffix)")
    }
}
