//
//  Size.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public struct Size {
    
    public var width: Int
    public var height: Int
    
    public init(width: Int, height: Int) {
        
        self.width = width
        self.height = height
    }
    
    public var topLeft: Coordinate { return Coordinate(x: 0, y: 0) }
    public var topRight: Coordinate { return Coordinate(x: width - 1, y: 0) }
    public var bottomLeft: Coordinate { return Coordinate(x: 0, y: height - 1) }
    public var bottomRight: Coordinate { return Coordinate(x: width - 1, y: height - 1) }
    public var center: Coordinate { return Coordinate(x: width / 2, y: height / 2) }
}
