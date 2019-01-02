//
//  Size.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public struct Size: Equatable {
    
    public var width: Int
    public var height: Int
    
    public var area: Int {
        return width * height
    }
    
    public init(width: Int, height: Int) {
        
        self.width = width
        self.height = height
    }
    
    public init(from coordinates: Coordinates) {
        
        let xValues = coordinates.map { $0.x }
        let yValues = coordinates.map { $0.y }
        
        self.init(
            width: (xValues.max() ?? 0) - (xValues.min() ?? 0) + 1,
            height: (yValues.max() ?? 0) - (yValues.min() ?? 0) + 1
        )
    }
    
    public func contains(point: Coordinate) -> Bool {
        
        return (0 ..< width).contains(point.x)
            && (0 ..< height).contains(point.y)
    }
    
    public var topLeft: Coordinate { return Coordinate(x: 0, y: 0) }
    public var topRight: Coordinate { return Coordinate(x: width - 1, y: 0) }
    public var bottomLeft: Coordinate { return Coordinate(x: 0, y: height - 1) }
    public var bottomRight: Coordinate { return Coordinate(x: width - 1, y: height - 1) }
    public var center: Coordinate { return Coordinate(x: width / 2, y: height / 2) }
}
