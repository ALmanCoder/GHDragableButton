//
//  ViewController.swift
//  GHDragableButton
//
//  Created by GuangHuiWu on 16/3/9.
//  Copyright © 2016年 GuangHuiWu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = UIColor.whiteColor()
        let dargableButton = GHDragableButton(frame: CGRectMake(0, 0, 60, 60))
        dargableButton.center = view.center
        dargableButton.setImage(UIImage(named: "bImg"), forState: .Normal)
        dargableButton.backgroundColor = UIColor.clearColor()
        dargableButton.drabaleEnable = true
        dargableButton.adsorbEnable = true
        dargableButton.addTarget(self, action: "dargableButtonClick:", forControlEvents: .TouchUpInside)
        view.addSubview(dargableButton)
        
        
        let dargableWindowButton = GHDragableButton(frame: CGRectMake(0, 0, 60, 60))
        dargableWindowButton.center = view.center
        dargableWindowButton.setImage(UIImage(named: "bImg"), forState: .Normal)
        dargableWindowButton.backgroundColor = UIColor.clearColor()
        dargableWindowButton.drabaleEnable = true
        dargableWindowButton.adsorbEnable = true
        dargableWindowButton.addTarget(self, action: "dargableWindowButtonClick:", forControlEvents: .TouchUpInside)
        let window = UIApplication.sharedApplication().delegate?.window
        window!!.addSubview(dargableWindowButton)
    }

    func dargableButtonClick(sender:UIButton) {
        NSLog("\(__FUNCTION__)")
    }
    
    func dargableWindowButtonClick(sender:UIButton) {
        NSLog("\(__FUNCTION__)")
    }
    
}

