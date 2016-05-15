//
//  PLA.swift
//  regressor
//
//  Created by Robin Malhotra on 15/05/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import Foundation
public extension Float
{
    public static func random(lower: Float, upper: Float) -> Float {
        let r = Float(arc4random()) / Float(UInt32.max)
        return (r * (upper - lower)) + lower
    }
}

func createF()
{
    let x1 = Float.random(-1.0, upper: 1.0)
    let x2 = Float.random(-1.0, upper: 1.0)
    let y1 = Float.random(-1.0, upper: 1.0)
    let y2 = Float.random(-1.0, upper: 1.0)
    
    let slope = (y2-y1)/(x2-x1)
    let intercept = y1 - x1*slope
    
}