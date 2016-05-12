//
//  linearRegressionResult.swift
//  regressor
//
//  Created by Robin Malhotra on 12/05/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import Foundation

class LinearRegressionResult
{
    var slope: Float = 0.0
    var intercept: Float = 0.0
    var lowestX: Float? = nil
    var highestX: Float? = nil
    
    lazy var plotPoints: [DataPoint] =
        {
            guard let lowX = self.lowestX, let highX = self.highestX else
            {
                return (0..<100).map{return DataPoint(x:Float($0),y:Float($0)*self.slope + self.intercept)}
            }
            let xvals = (0..<100).map{return lowX + (highX - lowX)/100*Float($0)} //had to do this because the expression was too long to compile. Fix in swift 3 , pliss?
            
            return xvals.map{return DataPoint(x:Float($0),y:Float($0)*self.slope + self.intercept)}
    }()
    
}