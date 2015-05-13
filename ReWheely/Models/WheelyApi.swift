//
//  WheelyApi.swift
//  ReWheely
//
//  Created by Arsen Gasparyan on 12/05/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import Argo
import Runes
import SwiftyJSON

class WheelyApi {
    class var sharedInstance: WheelyApi {
        struct Static {
            static let instance: WheelyApi = WheelyApi()
        }
        return Static.instance
    }
    
    var beforeRequest: Void -> Void = {}
    var afterRequest: Void -> Void = {}
    
    private var currentRequest: Request?
    typealias SuccessCallback = (cars: [Car], eta: Double?) -> (Void)
    typealias FailureCallback = (error: NSError?) -> (Void)
    
    internal func getCarsNearWith(coordinate: CLLocationCoordinate2D, success: SuccessCallback, failure: FailureCallback) {
        if let request = currentRequest {
            request.cancel()
            currentRequest = nil
        }
        
        beforeRequest()
        
        let url = "https://api.wheely.com/v5/cars?position=\(coordinate.latitude),\(coordinate.longitude)"
        currentRequest = Alamofire.request(.GET, url).responseJSON { [weak self] (_, _, data, error) in
            if(error != nil) {
                failure(error: error)
            } else {
                let json = JSON(data!)
                let eta = json["eta"].double
                let cars = json["cars"].arrayValue.map { JSON.parse($0.dictionaryObject!) }
                    .map { Car.decode($0).value }.filter { $0 != nil }.map { $0! }
                
                success(cars: cars, eta: eta)
            }

            self?.afterRequest()
            self?.currentRequest = nil
        }
    }
    
    private func responseHandler(_: NSURLRequest, _: NSHTTPURLResponse?, data: AnyObject?, error: NSError?) -> Void {
    
    }
}
