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
import WebKit
import SwiftyJSON
class ViewController: NSViewController {

    @IBOutlet weak var plotView: PlotView!
    @IBOutlet weak var webView: WebView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().bundlePath
        print(path)
        let baseURL = NSURL.fileURLWithPath("\(path)/Contents/Resources/JSChart/index.html")
        webView.mainFrame.loadRequest(NSURLRequest(URL: baseURL))
        plotView.frame = view.frame
        plotView.wantsLayer = true
        plotView.layer?.backgroundColor = NSColor.redColor().CGColor
        view.addSubview(plotView)
        onePerceptronRun(100)
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


    func getWeightVector(x1:Float,x2:Float,y1:Float,y2:Float) -> [Float]
    {
        return [x2-x1, y1-y2, x1*(y2-y1) - y1*(x2-x1)]
    }

    func getSlopeAndIntercept(weightVector:[Float])->(slope:Float, intercept:Float)
    {
        return (slope: -weightVector[1]/weightVector[0], intercept: -weightVector[2]/weightVector[0])
    }

    //Squarespace: Build it beautiful. Use code ATP for 10% off your first order.
    func getRandomLineInSquareSpace(lower:Float,upper:Float) -> [Float]
    {
        let x1 = Float.random(lower, upper: upper)
        let x2 = Float.random(lower, upper: upper)
        let y1 = Float.random(lower, upper: upper)
        let y2 = Float.random(lower, upper: upper)
        return getWeightVector(x1, x2: x2, y1: y1, y2: y2)
    }

    func onePerceptronRun(numberOfTrainingPoints : Int)
    {

        let startTime = CFAbsoluteTimeGetCurrent()
        let w = getRandomLineInSquareSpace(-1.0, upper: 1.0)
        let (slope,intercept) = getSlopeAndIntercept(w)
        let line = LinearRegressionResult(slope: slope, intercept: intercept, lowestX: -1.0, highestX: 1.0)
        let trainingPoints = (0..<numberOfTrainingPoints).map{_ in return DataPoint(x:Float.random(-1.0, upper: 1.0),y:Float.random(-1.0, upper: 1.0))}

        let json = JSON(trainingPoints.map{["x":$0.x,"y":$0.y]})
        let str = json.description
        let path = "\(NSBundle.mainBundle().bundlePath)/Contents/Resources/JSChart/points.json"

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
        {
            if NSFileManager.defaultManager().fileExistsAtPath(path)
            {
                do
                {
                    try NSFileManager.defaultManager().removeItemAtPath(path)
                }
                catch
                {
                    print("bahut bura hua")
                }
            }
             NSFileManager.defaultManager().createFileAtPath(path, contents: str.dataUsingEncoding(NSUTF8StringEncoding), attributes: nil)
            dispatch_async(dispatch_get_main_queue(),
            {
                print("ho gaya")
            })
        })
        for point in trainingPoints
        {
            print("[\(point.x),\(point.y)],")
        }
        print(line.plotPoints.first)
        print(line.plotPoints.last)
        var pluses : [DataPoint] = []
        var minuses : [DataPoint] = []

        // TODO: turn this into a filter
        for point in trainingPoints
        {
            if (point.y - slope*point.x - intercept)>0
            {
                pluses.append(point)
            }
            else
            {
                minuses.append(point)
            }
        }

        let plusSet = PointSet(points: pluses.map{Point(x: Double($0.x),y: Double($0.y))})
        plusSet.pointType = .Disk(radius: 4)
        plusSet.pointColor = NSColor.greenColor()
        plusSet.lineColor = nil
        plotView.addPointSet(plusSet)

        let minusSet = PointSet(points: minuses.map{Point(x: Double($0.x),y: Double($0.y))})
        minusSet.pointType = .Disk(radius: 4)
        minusSet.pointColor = NSColor.redColor()
        minusSet.lineColor = nil
        plotView.addPointSet(minusSet)

        let pointSet = PointSet(points: line.plotPoints.map{Point(x: Double($0.x),y: Double($0.y))})
        pointSet.pointType = .None
        pointSet.lineColor = NSColor.blueColor()
        plotView.addPointSet(pointSet)

        var xaxis = Axis(orientation: .Horizontal)
        xaxis.lineWidth = 2
        plotView.addAxis(xaxis)

        var yaxis = Axis(orientation: .Vertical)
        yaxis.lineWidth = 2
        plotView.addAxis(yaxis)

        var w2 = getRandomLineInSquareSpace(-1.0, upper: 1.0)
//        var w2 = [0.0 , 0.0 , 0.0]
        var counter = 0
        while true
        {
            counter+=1
            var check = false
            for point in trainingPoints
            {
                let firstPointResult = (point.y*w[0] + point.x*w[1] + 1*w[2]).sign()
                let secondPointResult = (point.y*w2[0] + point.x*w2[1] + 1*w2[2]).sign()
                if secondPointResult != firstPointResult
                {
                    check = true
                    w2[0] += point.y * (firstPointResult == .Positive ? 1 : -1)
                    w2[1] += point.x * (firstPointResult == .Positive ? 1 : -1)
                    w2[2] += 1 * (firstPointResult == .Positive ? 1 : -1)
                    break
                }
            }
            if check == false
            {
                break
            }
        }

        print(counter)

//        let origResults = trainingPoints.map{return ($0.y*w[0] + $0.x*w[1] + 1*w[2]).sign()}
//        let newResults = trainingPoints.map{return ($0.y*w2[0] + $0.x*w2[1] + 1*w2[2]).sign()}
//        print(origResults)
//        print(newResults)
        let (slope2,intercept2) = getSlopeAndIntercept(w2)
        let line2 = LinearRegressionResult(slope: slope2, intercept: intercept2, lowestX: -1.0, highestX: 1.0)
        print(line2.plotPoints.first)
        print(line2.plotPoints.last)
        let pointSet2 = PointSet(points: line2.plotPoints.map{Point(x: Double($0.x),y: Double($0.y))})
        pointSet2.pointType = .None
        pointSet2.lineColor = NSColor.orangeColor()
        plotView.addPointSet(pointSet2)
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for PLA: \(timeElapsed) s")
    }

    // MARK: Regression shouldn't be a property of the set, should be a separate thing.


      override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }

}
