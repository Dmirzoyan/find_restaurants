//
//  RestaurantsViewController.swift
//  FindRestaurants
//
//  Created by Davit Mirzoyan on 1/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import GoogleMaps

protocol RestaurantsInteracting {}

final class RestaurantsViewController: UIViewController {

    var interactor: RestaurantsInteracting!
    var locationManager: CLLocationManager!
    
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
    }
}

extension RestaurantsViewController: RestaurantsDisplaying {}
