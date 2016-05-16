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
        onePerceptronRun(10)
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
    

    
    func onePerceptronRun(numberOfTrainingPoints : Int)
    {
        let x1 = Float.random(-1.0, upper: 1.0)
        let x2 = Float.random(-1.0, upper: 1.0)
        let y1 = Float.random(-1.0, upper: 1.0)
        let y2 = Float.random(-1.0, upper: 1.0)
        
        let slope = (y2-y1)/(x2-x1)
        let intercept = y1 - x1*slope
        
        

        
        let trainingPoints = (0..<numberOfTrainingPoints).map{_ in return DataPoint(x:Float.random(-1.0, upper: 1.0),y:Float.random(-1.0, upper: 1.0))}
        print(trainingPoints)
        
        let pointSet = PointSet(points: trainingPoints.map{Point(x: Double($0.x),y: Double($0.y))})
        pointSet.pointType = .Disk(radius: 4)
        pointSet.pointColor = NSColor.redColor()
        pointSet.lineColor = nil
        plotView.addPointSet(pointSet)
        
        let line = LinearRegressionResult(slope: slope, intercept: intercept, lowestX: -1.0, highestX: 1.0)
        
        let pointSet2 = PointSet(points: line.plotPoints.map{Point(x: Double($0.x),y: Double($0.y))})
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
    
    
      override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}

