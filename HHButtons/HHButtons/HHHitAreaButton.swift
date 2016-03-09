//
//  HHHitAreaButton.swift
//  HHButtons
//
//  Created by Hung Trinh on 3/9/16.
//  Copyright © 2016 HH. All rights reserved.
//

import Foundation
import UIKit

public class HHHitAreaButton:UIButton {
    public var hitTestEdgeInsets: UIEdgeInsets = UIEdgeInsetsZero
}

extension HHHitAreaButton {
    override public func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        if (UIEdgeInsetsEqualToEdgeInsets(hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
            return super.pointInside(point, withEvent: event)
        }
        
        let relativeFrame = self.bounds
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets)
        
        return CGRectContainsPoint(hitFrame, point)
    }
}