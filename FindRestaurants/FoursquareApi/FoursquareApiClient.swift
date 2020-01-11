//
//  FoursquareApiClient.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

typealias FindRestaurantsCompletion = ([Restaurant], Error?) -> Void

protocol RestaurantsApiAccessing {
    func findRestaurants(
        latitude: Double,
        longitude: Double,
        radius: Int,
        limit: Int,
        completion: @escaping FindRestaurantsCompletion
    )
}

class FoursquareApiClient: RestaurantsApiAccessing {
    
    private static let clientId = "CLIENT_ID_PLACEHOLDER"
    private static let clientSecret = "CLIENT_SECRET_PLACEHOLDER"
    private static let foodCategoryId = "4d4b7105d754a06374d81259"
    
    enum Endpoints {
        static let base = "https://api.foursquare.com/v2/"
        
        case search(String, String, Int, Int)
        
        var urlString: String {
            switch self {
            case .search(let latitude, let longitude, let radius, let limit):
                return Endpoints.base + "venues/search?ll=\(latitude),\(longitude)" + "&categoryId=\(foodCategoryId)&limit=\(limit)" + "&radius=\(radius)" + "&client_id=\(clientId)&client_secret=\(clientSecret)&v=20200115"
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
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard
                let _ = response as? HTTPURLResponse,
                let data = data,
                error == nil
            else {
                self?.reportError("Unknown API response", completion: completion)
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(SearchVenuesResponse.self, from: data)
                
                guard
                    let venues = responseObject.response.venues,
                    responseObject.meta.code == 200
                else {
                    self?.reportError(
                        responseObject.meta.errorDetail ?? "Unknown API response",
                        completion: completion
                    )
                    return
                }
                
                OperationQueue.main.addOperation({
                    completion(venues, nil)
                })
                
            } catch {
                self?.reportError("Unknown API response", completion: completion)
            }
        }
        task.resume()
            
    }
    
    private func reportError(_ message: String, completion: @escaping FindRestaurantsCompletion) {
        let apiError = NSError(
            domain: "VenuesSearch",
            code: 0,
            userInfo: [NSLocalizedFailureReasonErrorKey: message]
        )
        
        OperationQueue.main.addOperation({
            completion([], apiError)
        })
    }
}
