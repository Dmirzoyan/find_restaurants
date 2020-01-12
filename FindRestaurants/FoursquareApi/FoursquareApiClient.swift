//
//  FoursquareApiClient.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

typealias FindRestaurantsCompletion = ([Restaurant], Error?) -> Void
typealias GetRestaurantDetailsCompletion = (RestaurantDetails?, Error?) -> Void

protocol RestaurantsApiAccessing {
    func findRestaurants(
        latitude: Double,
        longitude: Double,
        radius: Int,
        limit: Int,
        completion: @escaping FindRestaurantsCompletion
    )
    
    func getRestaurantDetails(restaurantId: String, completion: @escaping GetRestaurantDetailsCompletion)
}

final class FoursquareApiClient: RestaurantsApiAccessing {
    
    private static let clientId = "CLIENT_ID_PLACEHOLDER"
    private static let clientSecret = "CLIENT_SECRET_PLACEHOLDER"
    private static let foodCategoryId = "4d4b7105d754a06374d81259"
    
    enum Endpoints {
        static let base = "https://api.foursquare.com/v2/"
        
        case search(String, String, Int, Int)
        case venueInfo(String)
        
        var urlString: String {
            switch self {
            case .search(let latitude, let longitude, let radius, let limit):
                return Endpoints.base + "venues/search?ll=\(latitude),\(longitude)" + "&categoryId=\(foodCategoryId)&limit=\(limit)" + "&radius=\(radius)" + "&client_id=\(clientId)&client_secret=\(clientSecret)&v=20200115"
            case .venueInfo(let id):
                return Endpoints.base + "venues/\(id)" +
                    "?client_id=\(clientId)&client_secret=\(clientSecret)&v=20200115"
            }
        }
        
        var url: URL {
            return URL(string: urlString)!
        }
    }
    
    func findRestaurants(
        latitude: Double,
        longitude: Double,
        radius: Int,
        limit: Int,
        completion: @escaping FindRestaurantsCompletion
    ) {
        let latitudeStr = String(format:"%f", latitude)
        let longitudeStr = String(format:"%f", longitude)
        let request = URLRequest(url: Endpoints.search(latitudeStr, longitudeStr, radius, limit).url)
        
        networkRequestTask(request: request, response: SearchVenuesResponse.self) { [weak self] (response, error) in
            guard let response = response
            else {
                OperationQueue.main.addOperation({ completion([], error) })
                return
            }
            
            guard response.meta.code == 200
            else {
                OperationQueue.main.addOperation({ completion([], self?.error(with: "Unexpected API response")) })
                return
            }

            OperationQueue.main.addOperation({
                completion(response.response.venues.map({
                        Restaurant(id: $0.id, name: $0.name, location: $0.location)
                    }), nil)
            })
        }
    }
    
    func getRestaurantDetails(restaurantId: String, completion: @escaping GetRestaurantDetailsCompletion) {
        let request = URLRequest(url: Endpoints.venueInfo(restaurantId).url)
        
        networkRequestTask(request: request, response: GetVenueDetailsResponse.self) { [weak self] (response, error) in
            guard let response = response
            else {
                OperationQueue.main.addOperation({ completion(nil, error) })
                return
            }
            
            guard
                let venue = response.response.venue,
                response.meta.code == 200
            else {
                OperationQueue.main.addOperation({ completion(nil, self?.error(with: "Unexpected API response")) })
                return
            }

            OperationQueue.main.addOperation({
                if let group = venue.photos?.groups.first {
                    completion(RestaurantDetails(
                        url: venue.url,
                        phone: venue.contact?.formattedPhone,
                        photos: group.items.map({
                            RestaurantPhotoInfo(
                                prefix: $0.prefix,
                                suffix: $0.suffix,
                                width: $0.width,
                                height: $0.height
                        )
                    })), nil)
                } else {
                    completion(RestaurantDetails(
                        url: venue.url,
                        phone: venue.contact?.formattedPhone,
                        photos: []), nil
                    )
                }
            })
        }
    }
    
    private func networkRequestTask<ResponseType: Decodable>(
         request: URLRequest,
         response: ResponseType.Type,
         completion: @escaping (ResponseType?, Error?) -> Void
     ) {
         let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
             guard
                let _ = response as? HTTPURLResponse,
                let data = data,
                error == nil
             else {
                completion(nil, error)
                return
             }
             
             do {
                let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                completion(responseObject, nil)
             } catch {
                completion(nil, self?.error(with: "Failed to decode response message"))
             }
         }
         task.resume()
     }
    
    private func error(with message: String) -> Error {
        return NSError(domain: "FoursquareApi", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey: message])
    }
}
