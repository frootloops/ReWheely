//
//  MapViewController.swift
//  ReWheely
//
//  Created by Arsen Gasparyan on 11/05/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var requestDriver: UIButton!
    @IBOutlet weak var pinView: UIView!
    @IBOutlet weak var pinLoadingView: UIImageView!
    @IBOutlet weak var pinLoadedView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    
    private let api = WheelyApi.sharedInstance
    private var firstLaunch = true
    
    override func viewDidLoad() {
        configureView()
        configureMap()
//        configureApi()
        configureHeader()
        
        super.viewDidLoad()
    }
    
    // pragma - Actions
    
    @IBAction func returnToCurrentLocation() {
        mapView.setCenterCoordinate(mapView.userLocation.coordinate, animated: true)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.currentLocationButton.alpha = 0
        })
    }
    
    // pragma - MapKit
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        if (firstLaunch != true) { return }
        
        firstLaunch = false
        let coordinate = userLocation.location.coordinate
        setRegion(coordinate)
        
        api.getCarsNearWith(coordinate, success: didGetCars, failure: { error in
            1;
        })
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        showcurrentLocationButtonIfNeeded()
    }
    
    func didGetCars(cars: [Car], eta: Double?) {
        
        if let wait = eta {
            estimatedTimeLabel.text = "Est. arrival in \(Int(wait / 60)) mins"
        }
    }
    
    
    // pragma - Private area
    
    
    private func configureView() {
        let nav = self.navigationController!.navigationBar
        nav.barStyle = .Black
        nav.barTintColor = .blackColor()
        nav.tintColor = .whiteColor()
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "Logo")!)
        requestDriver.layer.cornerRadius = 18
    }
    
    private func configureMap() {
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    private func configureHeader() {
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = headerView.frame
        view.insertSubview(visualEffectView, belowSubview: headerView)
    }
    
    private func setRegion(coordinate: CLLocationCoordinate2D) {
        mapView.centerCoordinate = coordinate
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000)
        mapView.setRegion(region, animated: true)
    }
    
    private func showcurrentLocationButtonIfNeeded() {
        let userLocation = CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
        let centerLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        if currentLocationButton.alpha == 0 && centerLocation.distanceFromLocation(userLocation) > CLLocationDistance(150) {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.currentLocationButton.alpha = 1
            })
        }
    }

}