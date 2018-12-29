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
    
    static let zero = Coordinate(x: 0, y: 0)
    
    static func random(in range: Range<Int>) -> Coordinate {
        return Coordinate(
            x: Int.random(in: range),
            y: Int.random(in: range)
        )
    }
    
    static func random(in size: Size) -> Coordinate {
        return Coordinate(
            x: Int.random(in: 0 ..< size.width),
            y: Int.random(in: 0 ..< size.height)
        )
    }
    
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
    
    public var upperLeft: Coordinate { return Coordinate.upperLeft(of: self) }
    public var upperRight: Coordinate { return Coordinate.upperRight(of: self) }
    public var lowerLeft: Coordinate { return Coordinate.lowerLeft(of: self) }
    public var lowerRight: Coordinate { return Coordinate.lowerRight(of: self) }
    
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

extension Coordinate: CustomStringConvertible {
    
    public var description: String {
        return "(x: \(x), y: \(y))"
    }
}
