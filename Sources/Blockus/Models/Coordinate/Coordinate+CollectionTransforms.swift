//
//  Coordinate+CollectionTransforms.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

public typealias Coordinates = Set<Coordinate>

extension Set: TransformableCoordinateContainer where Element == Coordinate {
    
    public func applying(transform: Transform) -> Set<Element> {
        
        switch transform {
        case .normalized:
            return normalize(self)
            
        case .offset(by: let amount):
            return offset(self, by: amount)
            
        case .mirrored(axis: let axis):
            return mirror(self, on: axis)
            
        case .rotated(amount: let rotation):
            return rotate(self, by: rotation)
        }
    }
    
    public var coordinates: Coordinates {
        return self
    }
}

// MARK: - Transforms

func normalize(_ coordinates: Coordinates) -> Coordinates {
    
    let minX = coordinates.map { $0.x }.min() ?? 0
    let minY = coordinates.map { $0.y }.min() ?? 0
    
    let offset = Coordinate(x: -minX, y: -minY)
    return coordinates.setMap { $0.offset(by: offset) }
}

func mirror(_ coordinates: Coordinates, on axis: Axis) -> Coordinates {
    
    let size = Size(from: coordinates)
    let coordinates = coordinates
        .setMap { coord in coord.reflected(on: axis, at: size.center) }
    
    return normalize(coordinates)
}

func rotate(_ coordinates: Coordinates, by amount: Rotation) -> Coordinates {
    
    let size = Size(from: coordinates)
    let coordinates = coordinates
        .setMap { coord in coord.rotated(by: amount, about: size.center) }
    
    return normalize(coordinates)
}

func offset(_ coordinates: Coordinates, by offset: Coordinate) -> Coordinates {
    
    return coordinates
        .setMap { coord in coord.offset(by: offset) }
}
