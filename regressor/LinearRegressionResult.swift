//
//  linearRegressionResult.swift
//  regressor
//
//  Created by Robin Malhotra on 12/05/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import Foundation

struct LinearRegressionResult
{
    var slope: Float = 0.0
    var intercept: Float = 0.0
    var lowestX: Float? = nil
    var highestX: Float? = nil
    
	var plotPoints: [DataPoint]
	{
            guard let lowX = self.lowestX, let highX = self.highestX else
            {
                return (0..<101).map{return DataPoint(x:Float($0),y:Float($0)*self.slope + self.intercept)}
            }
            let xvals = (0..<101).map{return lowX + (highX - lowX)/100*Float($0)} //had to do this because the expression was too long to compile. Fix in swift 3 , pliss?
            
            return xvals.map{return DataPoint(x:Float($0),y:Float($0)*self.slope + self.intercept)}
    }
    
}

func linearlyRegress(dataSet: Set<DataPoint>)->LinearRegressionResult
{
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
