//
//  DataPoint.swift
//  regressor
//
//  Created by Robin Malhotra on 11/05/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import Foundation

struct DataPoint: Hashable
{
    let x: Float
    let y: Float
    
    var cGPoint: CGPoint
    {
        return CGPointMake(CGFloat(x), CGFloat(y))
    }
    var hashValue: Int
    {
        return ("\(x)\(y)").hashValue
    }
}

func ==(lhs:DataPoint,rhs:DataPoint) -> Bool
{
    return lhs.x == rhs.x && lhs.y == rhs.y
}