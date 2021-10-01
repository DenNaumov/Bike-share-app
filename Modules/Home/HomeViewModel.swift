//
//  HomeViewModel.swift
//  bike app
//
//  Created by Денис Наумов on 30.09.2021.
//  Copyright © 2021 Денис Наумов. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol VMToViewDelegate: AnyObject {
    func centerMapTo(coordinate: CLLocationCoordinate2D, zoomLevel: Float)
    func setupGMSCamera()
}

class HomeViewModel: NSObject {

    let locationManager = CLLocationManager()

    weak var viewDelegate: VMToViewDelegate?

    func onUserRequestSettings() {
        // TODO: open user profile
    }

    func loadUserProfile() {
        // TODO: load user profile
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
    }

    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            viewDelegate?.setupGMSCamera()
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .denied:
            break
        default:
            break
        }
    }
}

extension HomeViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerViewOnUserLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

    }

    func centerViewOnUserLocation() {
        guard let location = locationManager.location else { return }
        let coordinate = location.coordinate
        viewDelegate?.centerMapTo(coordinate: coordinate, zoomLevel: 17)
    }
}
