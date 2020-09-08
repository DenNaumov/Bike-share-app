//
//  MapViewController.swift
//  bikeapp
//
//  Created by Денис Наумов on 26.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class HomeViewController: UIViewController {

    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBalanceButton: UIButton!

    let locationManager = CLLocationManager()
    private let defaultZoomLevel: Float = 17.0

    override func viewDidLoad() {

        super.viewDidLoad()
        setupUserProfile()
        checkLocationServices()
    }
    
    @IBAction func userLocationButton(_ sender: Any) {

        centerViewOnUserLocation()
    }

    private func setupUserProfile() {

        userImageView.image = UIImage.init(named: "userpic")
        userNameLabel.text = "Robert Mack"
        userBalanceButton.titleLabel?.text = "$2.032"
    }

    private func checkLocationServices() {

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
    
    private func setupGMSCamera() {
        
        mapView.isMyLocationEnabled = true
        let zoomLevel = GMSCameraUpdate.zoom(to: defaultZoomLevel)
        mapView.animate(with: zoomLevel)
    }

    private func centerViewOnUserLocation() {

        guard let location = locationManager.location else { return }
        let coordinate = location.coordinate
        mapView.animate(toLocation: coordinate)
    }

    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            setupGMSCamera()
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

extension HomeViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        centerViewOnUserLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

    }
}
