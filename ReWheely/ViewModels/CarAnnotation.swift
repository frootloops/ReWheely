//
//  CarAnnotation.swift
//  ReWheely
//
//  Created by Arsen Gasparyan on 11/05/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import MapKit

class CarAnnotation: MKPointAnnotation {
    var car: Car!
    
    init(car: Car) {
        super.init()
        self.car = car
        self.coordinate = car.coordinate()
    }
}
