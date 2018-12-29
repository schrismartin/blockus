//
//  CoordinateContainer.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

protocol CoordinateContainer: Settable, Configurable {
    
    var coordinates: Coordinates { get set }
    var size: Size { get }
}

extension CoordinateContainer {
    
    var size: Size {
        return Size(from: coordinates)
    }
}

extension CoordinateContainer {
    
    func normalized() -> Self {
        
        return self.setting(path: \Self.coordinates) { coordinates in
            
            let minX = coordinates.map { $0.x }.min() ?? 0
            let minY = coordinates.map { $0.y }.min() ?? 0
            
            let offset = Coordinate(x: -minX, y: -minY)
            return coordinates.setMap { $0.offset(by: offset) }
        }
    }
    
    func mirrored(on axis: Axis) -> Self {
        
        return self.setting(path: \Self.coordinates) { coordinates in
            coordinates
                .setMap { coord in coord.reflected(on: axis, at: size.center) }
                .normalized()
        }
    }
    
    func rotated(by amount: DegreeAmount, direction: Direction) -> Self {
        
        return self.setting(path: \Self.coordinates) { coordinates in
            coordinates
                .setMap { coord in coord.rotated(by: amount, direction: direction, about: size.center) }
                .normalized()
        }
    }
}
