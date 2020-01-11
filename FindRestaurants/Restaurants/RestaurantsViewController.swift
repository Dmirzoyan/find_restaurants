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
    func viewRestaurantInfo(for coordinate: Coordinate)
}

final class RestaurantsViewController: UIViewController {

    var interactor: RestaurantsInteracting!
    var locationManager: CLLocationManager!
    var restaurantInfoView: RestaurantInfoView!
    var popupViewAnimator: PopupViewAnimating!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    private struct Constants {
        static let initialZoom: Float = 13
        static let restaurantInfoViewHeight: CGFloat = 500
        static let restaurantInfoViewPreviewHeight: CGFloat = 110
        static let animationDuration = 0.8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupRestaurantInfoView()
    }
    
    private func setupMapView() {
        setupMapStyle()

        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.animate(toZoom: Constants.initialZoom)
        mapView.delegate = self
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
    
    private func setupRestaurantInfoView() {
        restaurantInfoView = RestaurantInfoView()
        
        restaurantInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(restaurantInfoView)
        
        NSLayoutConstraint.activate([
            restaurantInfoView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: RestaurantInfoView.borderMargin
            ),
            restaurantInfoView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -RestaurantInfoView.borderMargin
            ),
            restaurantInfoView.heightAnchor.constraint(
                equalToConstant: Constants.restaurantInfoViewHeight
            ),
        ])
        
        let bottomConstraint = restaurantInfoView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: Constants.restaurantInfoViewHeight
        )
        bottomConstraint.isActive = true
        
        popupViewAnimator = PopupViewAnimator(
            hostView: view,
            popupView: restaurantInfoView,
            popupViewHeight: Constants.restaurantInfoViewHeight,
            popupPreviewHeight: Constants.restaurantInfoViewPreviewHeight,
            initialState: .closed,
            bottomConstraint: bottomConstraint
        )
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

extension RestaurantsViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        interactor.viewRestaurantInfo(for: Coordinate(
            latitude: marker.position.latitude,
            longitude: marker.position.longitude)
        )
        
        return true
    }
}

extension RestaurantsViewController: RestaurantsDisplaying {
    
    func display(_ restaurantLocations: [Coordinate]) {
        restaurantLocations.forEach { location in
            let marker = GMSMarker(position: CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            ))
            
            marker.iconView = UIImageView(image: UIImage(named: "marker"))
            marker.map = mapView
        }
    }
    
    func display(_ viewState: RestaurantInfoViewState) {
        popupViewAnimator.animateTransitionIfNeeded(
            to: PopupState.preview,
            isInteractionEnabled: false,
            duration: Constants.animationDuration
        )
        restaurantInfoView.set(viewState: viewState)
    }
    
    func displayAlert(with message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
    }
}