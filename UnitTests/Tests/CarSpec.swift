//
//  ReWheelyTests.swift
//  ReWheelyTests
//
//  Created by Arsen Gasparyan on 11/05/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import Quick
import Nimble
import Argo
import Runes
import CoreLocation


class CarSpec: QuickSpec {
    let cars = "{ \"cars\": [ { \"id\": \"1\", \"color\": \"000000\", \"bearing\": 3.2, \"position\": [ 55.749605, 37.58370333333333 ] }, { \"id\": \"2\", \"color\": \"000000\", \"bearing\": null, \"position\": [ 55.75249612734746, 37.56248344453677 ] }, ], \"eta\": 1.5 }"
    
    override func spec() {
        it("has correct decoder") {
            let response = "{ \"id\": \"1\", \"color\": \"000000\", \"bearing\": null, \"position\": [ 1, 2 ] }"
            let data = response.dataUsingEncoding(NSUTF8StringEncoding)!
            let json: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)!
            let car = decode(json) as Car!
            
            expect(car.id).to(equal("1"))
            expect(car.color).to(equal("000000"))
            expect(car.bearing).to(beNil())
            expect(car.latitude).to(equal(1 as CLLocationDegrees))
            expect(car.longitude).to(equal(2 as CLLocationDegrees))
            expect(car.coordinate().longitude).to(equal(car.longitude))
            expect(car.coordinate().latitude).to(equal(car.latitude))
        }
    }
}