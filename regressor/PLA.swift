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

