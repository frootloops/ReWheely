//
//  Car.swift
//  ReWheely
//
//  Created by Arsen Gasparyan on 11/05/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import Argo
import Runes
import CoreLocation

struct Car: Decodable {
    let id: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let color: String
    let bearing: Double?

    static func create(id: String)(name: String)(bearing: Double?)(position: [Double]) -> Car {
        return Car(id: id, latitude: position[0], longitude: position[1], color: name, bearing: bearing)
    }
    
    static func decode(j: JSON) -> Decoded<Car> {
        return Car.create
            <^> j <| "id"
            <*> j <| "color"
            <*> j <|? "bearing"
            <*> j <|| "position"
    }
    
    func coordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
}
