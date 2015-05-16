//
//  UIViewExtensions.swift
//  ReWheely
//
//  Created by Arsen Gasparyan on 16/05/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import UIKit

extension UIView {
    internal func rotation() {
        if (layer.animationForKey("pinRotation") != nil) {
            return;
        }
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = M_PI_2
        animation.duration = 1
        animation.cumulative = true
        animation.repeatCount = Float(CGFloat.max)
        
        layer.addAnimation(animation, forKey: "pinRotation")
    }
}
