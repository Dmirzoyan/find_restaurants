//
//  RestaurantsViewController.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import GoogleMaps

protocol RestaurantsInteracting {
    func findRestaurants(for coordinate: Coordinate, radius: Int, limit: Int)
}

final class RestaurantsViewController: UIViewController {

    var interactor: RestaurantsInteracting!
    var locationManager: CLLocationManager!
    private let markerIcon = UIImage(named: "marker")
    
    @IBOutlet weak var mapView: GMSMapView!
    
    private struct Constants {
        static let initialZoom: Float = 13
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
    }
    
    private func setupMapView() {
        setupMapStyle()

        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.animate(toZoom: Constants.initialZoom)
        locationManager.delegate = self
    }

    private func setupMapStyle() {
        guard let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "geojson")
        else {
            assertionFailure("Unable to load maps style")
            return
        }

        mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
    }
}

extension RestaurantsViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse
        else { return }

        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first
        else { return }

        mapView.camera = GMSCameraPosition(
            target: location.coordinate,
            zoom: Constants.initialZoom,
            bearing: 0,
            viewingAngle: 0
        )

        locationManager.stopUpdatingLocation()
        
        interactor.findRestaurants(
            for: Coordinate(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            ),
            radius: 4000,
            limit: 10
        )
    }
}

extension RestaurantsViewController: RestaurantsDisplaying {
    
    func display(_ restaurantLocations: [Coordinate]) {
        restaurantLocations.forEach { location in
            let marker = GMSMarker(
                position: CLLocationCoordinate2D(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
            )
            
            marker.iconView = UIImageView(image: markerIcon)
            marker.map = mapView
        }
    }
    
    func displayAlert(with message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
