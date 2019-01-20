//
//  CoordinateContainer.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

public protocol CoordinateContainer: Settable, Configurable {
    
    var coordinates: Coordinates { get }
    var size: Size { get }
}

extension CoordinateContainer {
    
    public var size: Size {
        
        return Size(from: coordinates)
    }
}

extension CoordinateContainer {
    
    public var availableMoves: Coordinates {
        
        let corners = coordinates.reduce(Coordinates()) { coordinates, coord in
            coordinates
                .inserting(coord.upperLeft)
                .inserting(coord.upperRight)
                .inserting(coord.lowerLeft)
                .inserting(coord.lowerRight)
        }
        
        return coordinates.reduce(corners) { coordinates, coord in
            coordinates
                .removing(coord)
                .removing(coord.above)
                .removing(coord.below)
                .removing(coord.left)
                .removing(coord.right)
        }
    }
    
    func coordinate(_ coordinate: Coordinate, isSurroundedOnAxis axis: Axis) -> Bool {
        
        return coordinate.adjacent(on: axis, in: self).count == 2
    }
    
    public var corners: Coordinates {
        
        return coordinates.reduce(Coordinates()) { coordinates, coord in
            coordinate(coord, isSurroundedOnAxis: .horizontal) || coordinate(coord, isSurroundedOnAxis: .vertical)
                ? coordinates
                : coordinates.inserting(coord)
        }
    }
    
    public var sides: Coordinates {
        
        return coordinates.reduce(Coordinates()) { coordinates, coord in
            coordinates
                .inserting(coord.above)
                .inserting(coord.right)
                .inserting(coord.left)
                .inserting(coord.below)
        }
    }
}

