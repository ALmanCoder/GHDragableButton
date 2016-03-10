//
//  GHDragableButton.swift
//  GHDragableButton
//
//  Created by GuangHuiWu on 16/3/9.
//  Copyright © 2016年 GuangHuiWu. All rights reserved.
//

import UIKit

class GHDragableButton: UIButton {
    
    let OFFY = 100.0
    var beginLocation : CGPoint!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        highlighted = true
        if !(objc_getAssociatedObject(self, &AssociationKeys.DragableEnableKey) != nil) { return }
        let touch = touches as NSSet
        beginLocation = touch.anyObject()?.locationInView(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        highlighted = false
        if !(objc_getAssociatedObject(self, &AssociationKeys.DragableEnableKey) != nil) { return }

        let touch = touches as NSSet
        let currentLocation = touch.anyObject()?.locationInView(self)
        let offsetX = (currentLocation?.x)! - beginLocation.x
        let offsetY = (currentLocation?.y)! - beginLocation.y
        center = CGPointMake(center.x + offsetX, center.y + offsetY)
        
        let leftLimitX = CGRectGetWidth(frame) / 2.0
        let rightLimitX = CGRectGetWidth(superview!.frame) - leftLimitX
        let topLimitY = CGRectGetHeight(frame) / 2.0
        let bottomLimitY = CGRectGetHeight(superview!.frame) - topLimitY
        
        if (center.x > rightLimitX) {
            center = CGPointMake(rightLimitX, center.y)
        } else if (center.x <= leftLimitX) {
            center = CGPointMake(leftLimitX, center.y)
        }
        
        if (center.y > bottomLimitY) {
            center = CGPointMake(center.x, bottomLimitY)
        } else if (center.y <= topLimitY) {
            center = CGPointMake(center.x, topLimitY)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchesEndWithDuration(0.20)
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        touchesEndWithDuration(0.01)
    }
    
    func touchesEndWithDuration(duration:Double) {
        
        if (highlighted) {
            sendActionsForControlEvents([.AllEvents,.AllTouchEvents])
            highlighted = false;
        }

        if (superview) != nil && (objc_getAssociatedObject(self, &AssociationKeys.DragableEnableKey) as! CBool){
            
            let superViewWidth = CGRectGetWidth(superview!.frame);
            let superViewHeight = CGRectGetHeight(superview!.frame);
            let viewWidth = CGRectGetWidth(frame);
            let viewHeight = CGRectGetHeight(frame);

            if (center.y < CGFloat(OFFY)) {
                UIView.animateWithDuration(duration, animations: { () -> Void in
                    self.center = CGPointMake(self.center.x, viewHeight / 2.0)
                })
            } else if center.y < superViewHeight - CGFloat(OFFY) {
                if center.x >= superViewWidth / 2.0 {
                    UIView.animateWithDuration(duration, animations: { () -> Void in
                        self.center = CGPointMake(superViewWidth - viewWidth / 2.0, self.center.y)
                    })
                } else {
                    UIView.animateWithDuration(duration, animations: { () -> Void in
                        self.center = CGPointMake(viewWidth / 2.0, self.center.y)
                    })
                }
            } else {
                UIView.animateWithDuration(duration, animations: { () -> Void in
                    self.center = CGPointMake(self.center.x, superViewHeight - viewHeight / 2.0)
                })
            }
        }
    }
}

extension GHDragableButton {
    
    private struct AssociationKeys {
        static var DragableEnableKey = false
        static var AdsorbEnableKey = false
    }
    // MARK: - 是否可拖拽
    var drabaleEnable :CBool? {
        get {
            return objc_getAssociatedObject(self, &AssociationKeys.DragableEnableKey) as? CBool
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociationKeys.DragableEnableKey, newValue as CBool?, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            }
        }
    }
    // MARK: - 是否可吸附
    var adsorbEnable :CBool? {
        get {
            return objc_getAssociatedObject(self, &AssociationKeys.AdsorbEnableKey) as? CBool
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociationKeys.AdsorbEnableKey, newValue as CBool?, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            }
        }
    }
}