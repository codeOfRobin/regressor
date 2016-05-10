//
//  ViewController.swift
//  regressor
//
//  Created by Robin Malhotra on 11/05/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import Cocoa
import CoreGraphics
import AppKit
import PlotKit
class ViewController: NSViewController {

    
    
    struct DataPoint
    {
        let x: Float
        let y: Float
        
        var eqCGPoint:CGPoint
        {
            return CGPointMake(CGFloat(x), CGFloat(y))
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let plotView = PlotView(frame: view.frame)
        plotView.wantsLayer = true
        plotView.layer?.backgroundColor = NSColor.redColor().CGColor
        view.addSubview(plotView)
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

