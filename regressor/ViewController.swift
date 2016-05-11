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

    
      override func viewDidLoad()
    {
        super.viewDidLoad()
        let plotView = PlotView(frame: view.frame)
        plotView.wantsLayer = true
        plotView.layer?.backgroundColor = NSColor.redColor().CGColor
        view.addSubview(plotView)
        let dataSet = Set([DataPoint(x:60.0,y:3.1),DataPoint(x:61.0,y:3.6),DataPoint(x:62.0,y:3.8),DataPoint(x:63.0,y:4.0),DataPoint(x:65.0,y:4.1)])
        linearlyRegress(dataSet)
    }
    
    // Regression shouldn't be a property of the set, should be a separate thing.
    
    
    func linearlyRegress(dataSet: Set<DataPoint>)
    {
//        let avgXs = dataSet.reduce(0.0) { (sum:Float, point:DataPoint) -> Float in
//            return sum + point.x
//        }/Float(dataSet.count)
        //same as above, we can write
        let sigmaX = dataSet.reduce(0.0){$0 + $1.x}
        let sigmaY = dataSet.reduce(0.0){$0 + $1.y}
        let sigmaXY = dataSet.reduce(0.0){$0 + $1.y*$1.x}
        let sigmaXSquare = dataSet.reduce(0.0){$0 + powf($1.x, 2.0)}
//        let avgYSquaredS = dataSet.reduce(0.0){$0 + powf($1.y, 2.0)}/Float(dataSet.count)
        let N = Float(dataSet.count)
        let slope = (N*sigmaXY - sigmaX*sigmaY)/(N*sigmaXSquare - pow(sigmaX,2.0))
        let intercept = (sigmaY - slope*sigmaX)/N
        
        print(slope)
        print(intercept)
        
    }
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

