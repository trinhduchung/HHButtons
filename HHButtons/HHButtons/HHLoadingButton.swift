//
//  HHLoadingButton.swift
//  HHButtons
//
//  Created by Hung on 3/7/16.
//  Copyright © 2016 HH. All rights reserved.
//

import Foundation
import UIKit

public class HHLoadingButton: UIButton {
    /// read only property
    private(set) var isLoading: Bool = false
    
    /// public properties
    public var animationDuration: Float?
    public var disableWhileLoading: Bool?
    
    /// private variables
    private var activityIndicatorView: UIActivityIndicatorView?
    private var currentButtonTitle: String?
    private var currentBounds: CGRect?
    private var currentCornerRadius: CGFloat?
}

// MARK: - UIButton override
extension HHLoadingButton {
    
    override public func awakeFromNib() {
        self.animationDuration = 0.3
        self.disableWhileLoading = true
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.updateActivityIndicatorViewFrame()
    }
}

// MARK: - Private methods
extension HHLoadingButton {
    
    private func addActivitiIndicatorView() {
        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .White)
        self.updateActivityIndicatorViewFrame()
        self.activityIndicatorView?.hidden = false
        self.activityIndicatorView?.startAnimating()
        self.superview?.addSubview(self.activityIndicatorView!)
    }
    
    private func updateActivityIndicatorViewFrame() {
        self.activityIndicatorView?.center = self.center
    }
    
    private func resetButtonTitle() {
        self.setTitle(self.currentButtonTitle, forState: .Normal)
    }
    
    private func resetEnableDisableState() {
        self.enabled = true
    }
    
    private func disableButton() {
        if (self.disableWhileLoading == true) {
            self.enabled = false
        }
    }
    
    private func clearButtonTitle() {
        self.setTitle("", forState: .Normal)
    }
    
    private func setCurrentButtonData() {
        self.currentButtonTitle = self.currentTitle
        self.currentBounds = self.bounds
        self.currentCornerRadius = self.layer.cornerRadius
    }
    
    /**
    Animates while show loading button, reform the button to cicle button
    */
    private func showLoadingAnimation() {
        /// De-scale animation
        let sizingAnimation: CABasicAnimation = CABasicAnimation(keyPath: "bounds")
        sizingAnimation.duration = Double(self.animationDuration! * 2) / 5
        
        if (CGRectGetWidth(self.bounds) > CGRectGetHeight(self.bounds)) {
            let rect = CGRectMake(self.layer.bounds.origin.x, self.layer.bounds.origin.y, self.layer.bounds.size.height, self.layer.bounds.size.height)
            sizingAnimation.toValue = NSValue(CGRect: rect)
        } else {
            let rect = CGRectMake(self.layer.bounds.origin.x, self.layer.bounds.origin.y, self.layer.bounds.size.width, self.layer.bounds.size.width)
            sizingAnimation.toValue = NSValue(CGRect: rect)
        }
        
        sizingAnimation.removedOnCompletion = false
        sizingAnimation.fillMode = kCAFillModeForwards
        
        self.layer.addAnimation(sizingAnimation, forKey: "de-scale")
        
        /// De-shape animation
        let shapeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "cornerRadius")
        shapeAnimation.beginTime = CACurrentMediaTime() + Double(self.animationDuration! * 2) / 5
        shapeAnimation.duration = Double(self.animationDuration! * 3) / 5
        shapeAnimation.toValue = (self.layer.bounds.size.height / 2.0)
        shapeAnimation.removedOnCompletion = false
        shapeAnimation.fillMode = kCAFillModeForwards
        
        self.layer.addAnimation(shapeAnimation, forKey: "make-circle-cornerRadius")
    }
    
    /**
    Animates while hiding loading button and transform the button to retangle
    */
    private func hideLoadingAnimation() {
        /// Re-set corner radius with animation
        let shapeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "cornerRadius")
        shapeAnimation.duration = Double(self.animationDuration! * 3) / 5
        shapeAnimation.toValue = (self.currentCornerRadius)
        shapeAnimation.removedOnCompletion = false
        shapeAnimation.fillMode = kCAFillModeForwards
        
        self.layer.addAnimation(shapeAnimation, forKey: "reset-cornerRadius")
        
        /// Re-scale animation
        let sizingAnimation: CABasicAnimation = CABasicAnimation(keyPath: "bounds")
        sizingAnimation.beginTime = CACurrentMediaTime() + Double(self.animationDuration! * 3) / 5
        sizingAnimation.duration = Double(self.animationDuration! * 2) / 5
        sizingAnimation.toValue = NSValue(CGRect: self.currentBounds!)
        sizingAnimation.removedOnCompletion = false
        sizingAnimation.fillMode = kCAFillModeForwards
        
        self.layer.addAnimation(sizingAnimation, forKey: "re-scale")
    }
}

// MARK: - Public methods
extension HHLoadingButton {
    
    public func showLoading() -> Void {
        self.isLoading = true
        self.addActivitiIndicatorView()
        self.setCurrentButtonData()
        self.clearButtonTitle()
        self.disableButton()
        self.showLoadingAnimation()
        
        self.setNeedsDisplay()
    }
    
    public func hideLoading() -> Void {
        self.isLoading = false
        self.activityIndicatorView?.removeFromSuperview()
        self.hideLoadingAnimation()
        self.resetEnableDisableState()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(self.animationDuration!) * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.resetButtonTitle()
        }
    }
}

