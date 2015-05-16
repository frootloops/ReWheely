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
    @IBOutlet weak var pinLoadingView: UIImageView! {
        didSet {
            let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.toValue = M_PI_2
            animation.duration = 1
            animation.cumulative = true
            animation.repeatCount = Float(CGFloat.max)
            
            pinLoadingView.layer.addAnimation(animation, forKey: "pinRotation")
        }
    }
    @IBOutlet weak var pinLoadedView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    
    private let api = WheelyApi.sharedInstance
    private var firstLaunch = true
    private var cars = [Car]() {
        didSet {
            presentCars(cars, oldCars: oldValue)
        }
    }
    private var timer = NSTimer()
    
    override func viewDidLoad() {
        configureView()
        configureMap()
        configureApi()
        configureHeader()
        
        super.viewDidLoad()
    }
    
    // pragma - Actions
    
    @IBAction func returnToCurrentLocation() {
        mapView.setCenterCoordinate(mapView.userLocation.coordinate, animated: true)
        
        UIView.animateWithDuration(0.3, animations: {
            self.currentLocationButton.alpha = 0
        })
    }
    
    // pragma - MapKit
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        if (!firstLaunch) { return }
        
        firstLaunch = false
        let coordinate = userLocation.location.coordinate
        setRegion(coordinate)
        
        api.getCarsNearWith(coordinate, success: didGetCars, failure: errorHandler)
    }
    
    func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
        pinLoadedView.alpha = 0
        pinLoadingView.alpha = 1
    }

    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        showcurrentLocationButtonIfNeeded()
        
        let coordinate = mapView.centerCoordinate
        api.getCarsNearWith(coordinate, success: didGetCars, failure: errorHandler)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let carAnnotation = annotation as? CarAnnotation {
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier("Car")
            if view == nil {
                view = CarAnnotationView(annotation: annotation, reuseIdentifier: "Car")
            } else {
                view.annotation = carAnnotation
            }
            return view
        }
        
        return .None
    }
    
    // pragma - Update
    
    internal func didGetCars(cars: [Car], eta: Double?) {
        self.cars = cars
        
        if let wait = eta {
            estimatedTimeLabel.text = "Est. arrival in \(Int(wait / 60)) mins"
        }
    }
    
    internal func backgroundUpdate() {
        let coordinate = mapView.centerCoordinate
        api.getCarsNearWith(coordinate, success: didGetCars, failure: errorHandler)
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
            UIView.animateWithDuration(1, animations: {
                self.currentLocationButton.alpha = 1
            })
        }
    }
    
    private func errorHandler(error: NSError?) {
    
    }
    
    private func presentCars(cars: [Car]?, oldCars: [Car]?) {
        if let newCars = cars {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(newCars.map{ CarAnnotation($0) })
        }
    }
    
    private func configureApi() {
        api.afterRequest = {
            self.pinLoadingView.alpha = 0
            self.pinLoadedView.alpha = 1
            self.pinLoadingView.layer.removeAllAnimations()
            
            self.configureBackgroundUpdate()
        }
    }
    
    private func configureBackgroundUpdate() {
        if (!timer.valid) {
            timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self,
                selector: "backgroundUpdate", userInfo: nil, repeats: false)
        }
    }

}