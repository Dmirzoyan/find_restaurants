//
//  RestaurantsInteractorSpec.swift
//  FindRestaurantsTests
//
//  Created by Davit Mirzoyan on 2/22/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Quick
import Nimble

@testable import FindRestaurants

final class RestaurantsInteractorSpec: QuickSpec {

    override func spec() {

        describe("\(RestaurantsInteractor.self)") {

            var sut: RestaurantsInteractor!
            var router: RestaurantsInternalRouteMock!
            var presenter: RestaurantsPresentingMock!
            var restaurantsApiClient: RestaurantsApiAccessingMock!
            var storageManager: StorageManagingMock!
            var restaurantsLimitQuery: RestaurantsLimitQueryingMock!
            var restaurantsQuery: RestaurantsQueryingMock!
            var mapOverlayOpacityQuery: MapOverlayOpacityQueryingMock!
            var queryThrottler: QueryThrottlingMock!

            beforeEach {
                router = RestaurantsInternalRouteMock()
                presenter = RestaurantsPresentingMock()
                restaurantsApiClient = RestaurantsApiAccessingMock()
                storageManager = StorageManagingMock()
                restaurantsLimitQuery = RestaurantsLimitQueryingMock()
                restaurantsQuery = RestaurantsQueryingMock()
                mapOverlayOpacityQuery = MapOverlayOpacityQueryingMock()
                queryThrottler = QueryThrottlingMock()

                sut = RestaurantsInteractor(
                    router: router,
                    presenter: presenter,
                    restaurantsApiClient: restaurantsApiClient,
                    storageManager: storageManager,
                    restaurantsLimitQuery: restaurantsLimitQuery,
                    restaurantsQuery: restaurantsQuery,
                    mapOverlayOpacityQuery: mapOverlayOpacityQuery,
                    queryThrottler: queryThrottler
                )
            }

            afterEach {
                sut = nil
                router = nil
                presenter = nil
                restaurantsApiClient = nil
                storageManager = nil
                restaurantsLimitQuery = nil
                restaurantsQuery = nil
                mapOverlayOpacityQuery = nil
                queryThrottler = nil
            }

            context("Given new query should not be performed") {

                beforeEach {
                    queryThrottler.stubs.shouldPerformNewQueryFor = false
                }

                context("When findRestaurants is called") {

                    beforeEach {
                        sut.findRestaurants(for: Coordinate(latitude: 0, longitude: 0), zoom: 0)
                    }

                    it("No API call is made") {
                        expect(restaurantsApiClient.captures.findRestaurantsLatitudeLongitudeRadiusLimitCompletion.count) == 0
                    }
                }
            }

            context("Given new query should be performed") {
                var coordinate: Coordinate!
                let limit = 5

                beforeEach {
                    coordinate = Coordinate(latitude: 1, longitude: 2)
                    
                    queryThrottler.stubs.shouldPerformNewQueryFor = true
                    restaurantsLimitQuery.stubs.limitFor = limit
                }

                afterEach {
                    coordinate = nil
                }

                context("When findRestaurants is called") {

                    beforeEach {
                        sut.findRestaurants(for: coordinate, zoom: 0.3)
                    }

                    it("An API call is made") {
                        let capture = restaurantsApiClient.captures.findRestaurantsLatitudeLongitudeRadiusLimitCompletion
                        
                        expect(capture.count) == 1
                        expect(capture.last?.limit) == limit
                        expect(capture.last?.latitude) == coordinate.latitude
                        expect(capture.last?.longitude) == coordinate.longitude
                    }
                    
                    context("When callback is executed") {
                        
                        beforeEach {
                            let capture = restaurantsApiClient.captures.findRestaurantsLatitudeLongitudeRadiusLimitCompletion
                            if let completion = capture.last?.completion {
                                completion([], nil)
                            }
                        }
                        
                        it("New restaurants lookup from store is made") {
                            expect(restaurantsQuery.captures.newRestaurantsIn.count) == 1
                        }
                        
                        it("Any new restaurants are added to store") {
                            expect(storageManager.captures.addRestaurants.count) == 1
                        }
                        
                        it("Any new restaurants are presented") {
                            expect(presenter.captures.presentRestaurants.count) == 1
                        }
                    }
                }
            }
            
            context("Given restaurant details are available in store") {

                beforeEach {
                    restaurantsQuery.stubs.restaurantFor = Restaurant(
                        id: "",
                        name: "",
                        location: Location(address: "", lat: 0, lng: 0, distance: 0, postalCode: "", city: "", country: ""),
                        details: RestaurantDetails(url: "", phone: "", photos: [])
                    )
                }

                context("When viewRestaurantInfo is called") {

                    beforeEach {
                        sut.viewRestaurantInfo(for: Coordinate(latitude: 0, longitude: 0))
                    }

                    it("No API call is made") {
                        expect(restaurantsApiClient.captures.getRestaurantDetailsRestaurantIdCompletion.count) == 0
                    }
                    
                    it("Restaurant details are presented") {
                        expect(presenter.captures.presentRestaurantInfo.count) == 1
                    }
                }
            }
            
            context("Given restaurant details are not available in store") {

                beforeEach {
                    restaurantsQuery.stubs.restaurantFor = Restaurant(
                        id: "",
                        name: "",
                        location: Location(address: "", lat: 0, lng: 0, distance: 0, postalCode: "", city: "", country: "")
                    )
                }

                context("When viewRestaurantInfo is called") {

                    beforeEach {
                        sut.viewRestaurantInfo(for: Coordinate(latitude: 0, longitude: 0))
                    }

                    it("An API call is made") {
                        expect(restaurantsApiClient.captures.getRestaurantDetailsRestaurantIdCompletion.count) == 1
                    }
                    
                    context("When callback is executed") {
                        
                        beforeEach {
                            let capture = restaurantsApiClient.captures.getRestaurantDetailsRestaurantIdCompletion
                            if let completion = capture.last?.completion {
                                completion(RestaurantDetails(url: "", phone: "", photos: []), nil)
                            }
                        }                        
                        
                        it("Restaurant details are added to store") {
                            expect(storageManager.captures.addRestaurantDetailsRestaurantIdDetails.count) == 1
                        }
                        
                        it("Restaurant details are presented") {
                            expect(presenter.captures.presentRestaurantInfo.count) == 1
                        }
                    }
                }
            }
        }
    }
}

