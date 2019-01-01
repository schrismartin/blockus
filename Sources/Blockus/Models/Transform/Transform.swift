//
//  Transform.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

public enum Transform {
    case normalized
    case offset(by: Coordinate)
    case mirrored(axis: Axis)
    case rotated(amount: Rotation)
}
