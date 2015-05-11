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
    
    private var rotateView: UIView!,
    maskImage: UIImageView!,
    overlayImage: UIImageView!,
    whiteImage: UIImageView!
    
    override init!(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, 0, 70, 70))
        
        rotateView = UIView(frame: CGRectMake(0, 0, 70, 70))
        addSubview(rotateView)
        
        maskImage = UIImageView(frame: CGRectMake(0, 0, 70, 70))
        maskImage.image = UIImage(named: "PinCarMask")!.imageWithRenderingMode(.AlwaysTemplate)
        maskImage.contentMode = .Center
        rotateView.addSubview(maskImage)
        
        overlayImage = UIImageView(frame: CGRectMake(0, 0, 70, 70))
        overlayImage.image = UIImage(named: "PinCarOverlayDark")!.imageWithRenderingMode(.AlwaysTemplate)
        overlayImage.contentMode = .Center
        rotateView.addSubview(overlayImage)
        
        whiteImage = UIImageView(frame: CGRectMake(0, 0, 70, 70))
        whiteImage.image = UIImage(named: "PinCarOverlayLight")!.imageWithRenderingMode(.AlwaysTemplate)
        whiteImage.contentMode = .Center
        rotateView.addSubview(whiteImage)
    }
    
    internal func update() {
        if let carAnnotation = self.annotation as? CarAnnotation {
            if let bearing = carAnnotation.car.bearing {
                let angle = CGFloat(bearing * M_PI / 180.0 + M_PI_2 + M_PI)
                self.rotateView?.transform = CGAffineTransformMakeRotation(angle)
            }
            
            self.maskImage.hidden = false
            self.overlayImage?.hidden = false
            self.whiteImage?.hidden = true
            self.maskImage.tintColor = UIColor.blackColor()
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