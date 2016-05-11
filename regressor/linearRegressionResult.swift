//
//  linearRegressionResult.swift
//  regressor
//
//  Created by Robin Malhotra on 12/05/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import Foundation

struct linearRegressionResult
{
    let slope: Float
    let intercept: Float
    let lowestX: Float?
    let lowestY: Float?
    
    lazy var plotPoints: [DataPoint] =
    {
        guard let lowX = self.lowestX, let lowY = self.lowestY else
        {
            return (0..<100).map{return DataPoint(x:Float($0),y:Float($0)*self.slope + self.intercept)}
        }
        return [DataPoint(x:60.0,y:3.1),DataPoint(x:61.0,y:3.6),DataPoint(x:62.0,y:3.8),DataPoint(x:63.0,y:4.0),DataPoint(x:65.0,y:4.1)]
    }()
}