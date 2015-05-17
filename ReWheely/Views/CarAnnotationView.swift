//
//  CarAnnotationView.swift
//  ReWheely
//
//  Created by Arsen Gasparyan on 11/05/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import UIKit
import MapKit

class CarAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation! {
        didSet {
            self.update()
        }
    }
    
    private var rotateView: UIView!
    private var maskImage: UIImageView!
    private var overlayImage: UIImageView!
    private var whiteImage: UIImageView!
    private let carFrame = CGRectMake(0, 0, 70, 70)
    
    override init!(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: carFrame)
        
        rotateView = UIView(frame: carFrame)
        addSubview(rotateView)
        
        maskImage = UIImageView(frame: carFrame)
        maskImage.image = UIImage(named: "PinCarMask")!.imageWithRenderingMode(.AlwaysTemplate)
        maskImage.contentMode = .Center
        rotateView.addSubview(maskImage)
        
        overlayImage = UIImageView(frame: carFrame)
        overlayImage.image = UIImage(named: "PinCarOverlayDark")
        overlayImage.contentMode = .Center
        rotateView.addSubview(overlayImage)
        
        whiteImage = UIImageView(frame: carFrame)
        whiteImage.image = UIImage(named: "PinCarOverlayLight")
        whiteImage.contentMode = .Center
        rotateView.addSubview(whiteImage)
    }
    
    internal func update() {
        if let carAnnotation = self.annotation as? CarAnnotation {
            let car = carAnnotation.car
            if let bearing = car.bearing {
                let angle = CGFloat(bearing * M_PI / 180.0 + M_PI_2 + M_PI)
                self.rotateView!.transform = CGAffineTransformMakeRotation(angle)
            }
            
            if (car.color.uppercaseString == "FFFFFF") {
                self.maskImage.hidden = true
                self.overlayImage.hidden = true
                self.whiteImage.hidden = false
                self.whiteImage.tintColor = UIColor.whiteColor()
            } else {
                self.maskImage.hidden = false
                self.overlayImage.hidden = false
                self.whiteImage.hidden = true
                self.maskImage.tintColor = UIColor(rgba: "#\(car.color)")
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.alpha = 1
        self.rotateView!.layer.removeAllAnimations()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}