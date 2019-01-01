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
    
    func applying(transform: Transform) -> Self
}

extension CoordinateContainer {
    
    public var size: Size {
        
        return Size(from: coordinates)
    }
}

extension CoordinateContainer {
    
    func applying(transforms: TransformCollection) -> Self {
        
        return transforms.transforms.reduce(self) { container, transform in
            container.applying(transform: transform)
        }
    }
    
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
}

