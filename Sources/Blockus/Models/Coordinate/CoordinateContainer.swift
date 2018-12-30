//
//  CoordinateContainer.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

public protocol CoordinateContainer: Settable, Configurable {
    
    var coordinates: Coordinates { get set }
    var size: Size { get }
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
    
    func applying(transform: Transform) -> Self {
        
        switch transform {
        case .mirrored(axis: let axis):
            return self.mirrored(on: axis)
            
        case .rotated(amount: let amount):
            return self.rotated(by: amount)
        }
    }
    
    func offset(by offset: Coordinate) -> Self {
        
        return setting(path: \Self.coordinates) { coords in
            coords.setMap { coord in coord.offset(by: offset) }
        }
    }
}

extension CoordinateContainer {
    
    public func normalized() -> Self {
        
        return self.setting(path: \Self.coordinates) { coordinates in
            
            let minX = coordinates.map { $0.x }.min() ?? 0
            let minY = coordinates.map { $0.y }.min() ?? 0
            
            let offset = Coordinate(x: -minX, y: -minY)
            return coordinates.setMap { $0.offset(by: offset) }
        }
    }
    
    public func mirrored(on axis: Axis) -> Self {
        
        return self.setting(path: \Self.coordinates) { coordinates in
            coordinates
                .setMap { coord in coord.reflected(on: axis, at: size.center) }
                .normalized()
        }
    }
    
    public func rotated(by amount: Rotation) -> Self {
        
        return self.setting(path: \Self.coordinates) { coordinates in
            coordinates
                .setMap { coord in coord.rotated(by: amount, about: size.center) }
                .normalized()
        }
    }
}
