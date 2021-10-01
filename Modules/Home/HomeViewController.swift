//
//  MapViewController.swift
//  Bike App
//
//  Created by Денис Наумов on 26.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class HomeViewController: UIViewController, VMToViewDelegate {

    @IBOutlet var mapView: GMSMapView!

    let vm = HomeViewModel()
    private let defaultZoomLevel: Float = 17.0

    override func viewDidLoad() {
        super.viewDidLoad()
        vm.viewDelegate = self
        vm.checkLocationServices()
    }

    @IBAction func onLocationButtonPress(_ sender: Any) {
        showUserLocationOnMap()
    }

    @IBAction func userSettingsButtonPress(_ sender: Any) {
        openUserProfile()
    }

    func centerMapTo(coordinate: CLLocationCoordinate2D, zoomLevel: Float) {
        mapView.animate(toLocation: coordinate)
        mapView.animate(toZoom: defaultZoomLevel)
    }

    func setupGMSCamera() {
        mapView.isMyLocationEnabled = true
        let zoomLevel = GMSCameraUpdate.zoom(to: defaultZoomLevel)
        mapView.animate(with: zoomLevel)
    }

    private func showUserLocationOnMap() {
        vm.centerViewOnUserLocation()
//        zoomToUser()
    }

    private func zoomToUser() {
        mapView.animate(toZoom: defaultZoomLevel)
    }

    private func openUserProfile() {
        vm.loadUserProfile()
    }
}
