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
}

extension Coordinate {
    
    public var above: Coordinate {
        return setting(path: \Coordinate.y, using: Int.decr)
    }
    
    public var below: Coordinate {
        return setting(path: \Coordinate.y, using: Int.incr)
    }
    
    public var left: Coordinate {
        return setting(path: \Coordinate.x, using: Int.decr)
    }
    
    public var right: Coordinate {
        return setting(path: \Coordinate.x, using: Int.incr)
    }
}

extension Coordinate {
    
    public var upperLeft: Coordinate {
        return above.left
    }
    
    public var upperRight: Coordinate {
        return above.right
    }
    
    public var lowerLeft: Coordinate {
        return below.left
    }
    
    public var lowerRight: Coordinate {
        return below.right
    }
}

extension Coordinate: CustomStringConvertible {
    
    public var description: String {
        return "(x: \(x), y: \(y))"
    }
}
