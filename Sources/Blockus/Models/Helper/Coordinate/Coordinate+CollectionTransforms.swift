//
//  Coordinate+CollectionTransforms.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

public typealias Coordinates = Set<Coordinate>

extension Set: CoordinateContainer where Element == Coordinate {
    var coordinates: Coordinates {
        get { return self }
        set { self = newValue }
    }
}
