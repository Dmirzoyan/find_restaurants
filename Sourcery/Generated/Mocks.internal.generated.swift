// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import FindRestaurants
import Foundation
import UIKit

class MapOverlayOpacityQueryingMock: MapOverlayOpacityQuerying {

    struct Captures {
        var opacityFor = [OpacityFor]()

        struct OpacityFor {
            let zoom: Float
        }
    }

    struct Stubs {
        lazy var opacityFor: Float! = 0
    }

    var captures = Captures()
    var stubs = Stubs()

    func opacity(for zoom: Float) -> Float {
        captures.opacityFor.append(Captures.OpacityFor(zoom: zoom))
        return stubs.opacityFor
    }
}

class QueryThrottlingMock: QueryThrottling {

    struct Captures {
        var shouldPerformNewQueryFor = [ShouldPerformNewQueryFor]()

        struct ShouldPerformNewQueryFor {
            let zoom: Float
        }
    }

    struct Stubs {
        lazy var shouldPerformNewQueryFor: Bool! = false
    }

    var captures = Captures()
    var stubs = Stubs()

    func shouldPerformNewQuery(for zoom: Float) -> Bool {
        captures.shouldPerformNewQueryFor.append(Captures.ShouldPerformNewQueryFor(zoom: zoom))
        return stubs.shouldPerformNewQueryFor
    }
}

class RestaurantsApiAccessingMock: RestaurantsApiAccessing {

    struct Captures {
        var findRestaurantsLatitudeLongitudeRadiusLimitCompletion = [FindRestaurantsLatitudeLongitudeRadiusLimitCompletion]()
        var getRestaurantDetailsRestaurantIdCompletion = [GetRestaurantDetailsRestaurantIdCompletion]()

        struct FindRestaurantsLatitudeLongitudeRadiusLimitCompletion {
            let latitude: Double
            let longitude: Double
            let radius: Int
            let limit: Int
            let completion: FindRestaurantsCompletion
        }

        struct GetRestaurantDetailsRestaurantIdCompletion {
            let restaurantId: String
            let completion: GetRestaurantDetailsCompletion
        }
    }

    struct Stubs {
    }

    var captures = Captures()
    var stubs = Stubs()

    func findRestaurants(        latitude: Double,        longitude: Double,        radius: Int,        limit: Int,        completion: @escaping FindRestaurantsCompletion    ) {
        captures.findRestaurantsLatitudeLongitudeRadiusLimitCompletion.append(Captures.FindRestaurantsLatitudeLongitudeRadiusLimitCompletion(latitude: latitude, longitude: longitude, radius: radius, limit: limit, completion: completion))
    }

    func getRestaurantDetails(restaurantId: String, completion: @escaping GetRestaurantDetailsCompletion) {
        captures.getRestaurantDetailsRestaurantIdCompletion.append(Captures.GetRestaurantDetailsRestaurantIdCompletion(restaurantId: restaurantId, completion: completion))
    }
}

class RestaurantsInternalRouteMock: RestaurantsInternalRoute {

    struct Captures {
    }

    struct Stubs {
    }

    var captures = Captures()
    var stubs = Stubs()
}

class RestaurantsLimitQueryingMock: RestaurantsLimitQuerying {

    struct Captures {
        var limitFor = [LimitFor]()

        struct LimitFor {
            let zoom: Float
        }
    }

    struct Stubs {
        lazy var limitFor: Int! = 0
    }

    var captures = Captures()
    var stubs = Stubs()

    func limit(for zoom: Float) -> Int {
        captures.limitFor.append(Captures.LimitFor(zoom: zoom))
        return stubs.limitFor
    }
}

class RestaurantsPresentingMock: RestaurantsPresenting {

    struct Captures {
        var presentRestaurants = [PresentRestaurants]()
        var presentRestaurantInfo = [PresentRestaurantInfo]()
        var presentOverlayWith = [PresentOverlayWith]()
        var presentAlertWith = [PresentAlertWith]()

        struct PresentRestaurants {
            let restaurants: [Restaurant]
        }

        struct PresentRestaurantInfo {
            let restaurantInfo: Restaurant
        }

        struct PresentOverlayWith {
            let opacity: Float
        }

        struct PresentAlertWith {
            let message: String
        }
    }

    struct Stubs {
    }

    var captures = Captures()
    var stubs = Stubs()

    func present(restaurants: [Restaurant]) {
        captures.presentRestaurants.append(Captures.PresentRestaurants(restaurants: restaurants))
    }

    func present(restaurantInfo: Restaurant) {
        captures.presentRestaurantInfo.append(Captures.PresentRestaurantInfo(restaurantInfo: restaurantInfo))
    }

    func presentOverlay(with opacity: Float) {
        captures.presentOverlayWith.append(Captures.PresentOverlayWith(opacity: opacity))
    }

    func presentAlert(with message: String) {
        captures.presentAlertWith.append(Captures.PresentAlertWith(message: message))
    }
}

class RestaurantsQueryingMock: RestaurantsQuerying {

    struct Captures {
        var restaurantFor = [RestaurantFor]()
        var newRestaurantsIn = [NewRestaurantsIn]()

        struct RestaurantFor {
            let coordinate: Coordinate
        }

        struct NewRestaurantsIn {
            let list: [Restaurant]
        }
    }

    struct Stubs {
        var restaurantFor: Restaurant?
        lazy var newRestaurantsIn: [Restaurant]! = []
    }

    var captures = Captures()
    var stubs = Stubs()

    func restaurant(for coordinate: Coordinate) -> Restaurant? {
        captures.restaurantFor.append(Captures.RestaurantFor(coordinate: coordinate))
        return stubs.restaurantFor
    }

    func newRestaurants(in list: [Restaurant]) -> [Restaurant] {
        captures.newRestaurantsIn.append(Captures.NewRestaurantsIn(list: list))
        return stubs.newRestaurantsIn
    }
}

class StorageManagingMock: StorageManaging {

    struct Captures {
        var addRestaurants = [AddRestaurants]()
        var addRestaurantDetailsRestaurantIdDetails = [AddRestaurantDetailsRestaurantIdDetails]()

        struct AddRestaurants {
            let restaurants: [Restaurant]
        }

        struct AddRestaurantDetailsRestaurantIdDetails {
            let restaurantId: String
            let details: RestaurantDetails
        }
    }

    struct Stubs {
    }

    var captures = Captures()
    var stubs = Stubs()

    func add(restaurants: [Restaurant]) {
        captures.addRestaurants.append(Captures.AddRestaurants(restaurants: restaurants))
    }

    func addRestaurantDetails(restaurantId: String, details: RestaurantDetails) {
        captures.addRestaurantDetailsRestaurantIdDetails.append(Captures.AddRestaurantDetailsRestaurantIdDetails(restaurantId: restaurantId, details: details))
    }
}
