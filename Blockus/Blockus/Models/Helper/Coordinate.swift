//
//  Coordinate.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public struct Coordinate: Hashable, Settable {
    public var x: Int
    public var y: Int
    
    public init(x: Int, y: Int) {
        
        self.x = x
        self.y = y
    }
    
    public func offset(by offset: Coordinate) -> Coordinate {
        return self
            .setting(path: \.x) { x in x + offset.x }
            .setting(path: \.y) { y in y + offset.y }
    }
}

extension Coordinate {
    
    public var above: Coordinate { return Coordinate.above(self) }
    public var below: Coordinate { return Coordinate.below(self) }
    public var left: Coordinate { return Coordinate.left(of: self) }
    public var right: Coordinate { return Coordinate.right(of: self) }
    
    public static func above(_ other: Coordinate) -> Coordinate {
        return other.setting(path: \Coordinate.y, using: Int.decr)
    }
    
    public static func below(_ other: Coordinate) -> Coordinate {
        return other.setting(path: \Coordinate.y, using: Int.incr)
    }
    
    public static func left(of other: Coordinate) -> Coordinate {
        return other.setting(path: \Coordinate.x, using: Int.decr)
    }
    
    public static func right(of other: Coordinate) -> Coordinate {
        return other.setting(path: \Coordinate.x, using: Int.incr)
    }
}

extension Coordinate {
    
    public static func upperLeft(of other: Coordinate) -> Coordinate {
        return above(left(of: other))
    }
    
    public static func upperRight(of other: Coordinate) -> Coordinate {
        return above(right(of: other))
    }
    
    public static func lowerLeft(of other: Coordinate) -> Coordinate {
        return below(left(of: other))
    }
    
    public static func lowerRight(of other: Coordinate) -> Coordinate {
        return below(right(of: other))
    }
}

extension Coordinate {
    
    public func reflected(on axis: Axis, at point: Coordinate) -> Coordinate {
        return Coordinate.reflect(self, on: axis, at: point)
    }
    
    public static func reflect(_ coordinate: Coordinate, on axis: Axis, at point: Coordinate) -> Coordinate {
        
        switch axis {
        case .horizontal:
            let distance = point.x - coordinate.x
            return coordinate.setting(path: \.x, to: point.x + distance)
            
        case .vertical:
            let distance = point.y - coordinate.y
            return coordinate.setting(path: \.y, to: point.y + distance)
        }
    }
}

extension Coordinate {
    
    public func rotated(by amount: DegreeAmount, direction: Direction, about point: Coordinate) -> Coordinate {
        
        return Coordinate.rotate(self, by: amount, direction: direction, about: point)
    }
    
    public static func rotate(_ coordinate: Coordinate, by amount: DegreeAmount, direction: Direction, about origin: Coordinate) -> Coordinate {
        
        switch amount {
        case .quarter:
            
            let theta = amount.angle(direction: direction)
            
            let x = (cos(theta) * Double(coordinate.x - origin.x) - sin(theta) * Double(coordinate.y - origin.y) + Double(origin.x))
            let y = (sin(theta) * Double(coordinate.x - origin.x) - cos(theta) * Double(coordinate.y - origin.y) + Double(origin.y))
            
            return Coordinate(x: Int(round(x)), y: Int(round(y)))
            
        case .half:
            let quarter = rotate(coordinate, by: .quarter, direction: direction, about: origin)
            return rotate(quarter, by: .quarter, direction: direction, about: origin)
        }
    }
}
