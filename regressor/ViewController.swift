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
    
    @IBOutlet weak var plotView: PlotView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        plotView.frame = view.frame
        plotView.wantsLayer = true
        plotView.layer?.backgroundColor = NSColor.redColor().CGColor
        view.addSubview(plotView)
        linearRegressionDemo()
        
        print(Float.random(-1.0, upper: 1.0))
    }
    
    func linearRegressionDemo()
    {
        let dataSet = Set([DataPoint(x:60.0,y:3.1),DataPoint(x:61.0,y:3.6),DataPoint(x:62.0,y:3.8),DataPoint(x:63.0,y:4.0),DataPoint(x:65.0,y:4.1)])
        
        let pointSet = PointSet(points: dataSet.map{Point(x: Double($0.x),y: Double($0.y))})
        
        pointSet.pointType = .Disk(radius: 4)
        pointSet.pointColor = NSColor.redColor()
        pointSet.lineColor = nil
        plotView.addPointSet(pointSet)
        
        let linearResult = linearlyRegress(dataSet)
        let pointSet2 = PointSet(points: linearResult.plotPoints.map{Point(x: Double($0.x),y: Double($0.y))})
        pointSet2.pointType = .None
        pointSet2.lineColor = NSColor.blueColor()
        
        plotView.addPointSet(pointSet2)
        
        var xaxis = Axis(orientation: .Horizontal)
        xaxis.lineWidth = 2
        plotView.addAxis(xaxis)
        
        var yaxis = Axis(orientation: .Vertical)
        yaxis.lineWidth = 2
        plotView.addAxis(yaxis)
    }
    

    // Regression shouldn't be a property of the set, should be a separate thing.
    
    
    func linearlyRegress(dataSet: Set<DataPoint>)->LinearRegressionResult
    {
        //        let avgXs = dataSet.reduce(0.0) { (sum:Float, point:DataPoint) -> Float in
        //            return sum + point.x
        //        }/Float(dataSet.count)
        //same as above, we can write
        let sigmaX = dataSet.reduce(0.0){$0 + $1.x}
        let sigmaY = dataSet.reduce(0.0){$0 + $1.y}
        let sigmaXY = dataSet.reduce(0.0){$0 + $1.y*$1.x}
        let sigmaXSquare = dataSet.reduce(0.0){$0 + powf($1.x, 2.0)}
        let N = Float(dataSet.count)
        let slope = (N*sigmaXY - sigmaX*sigmaY)/(N*sigmaXSquare - pow(sigmaX,2.0))
        let intercept = (sigmaY - slope*sigmaX)/N
        
        print(slope)
        print(intercept)
        
        let lowestX = dataSet.minElement({ (x, y) -> Bool in
            return x.x < y.x
        })
        let highestX = dataSet.maxElement({ (x, y) -> Bool in
            return x.x < y.x
        })
        
        let result = LinearRegressionResult(slope: slope, intercept: intercept, lowestX: lowestX?.x, highestX: highestX?.x)
        return result
        
    }
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}

