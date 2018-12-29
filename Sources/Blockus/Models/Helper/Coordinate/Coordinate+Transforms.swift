//
//  Coordinate+Transforms.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

extension Coordinate {
    
    public func reflected(on axis: Axis, at point: Coordinate) -> Coordinate {
        return Coordinate.reflect(self, on: axis, at: point)
    }
    
    public static func reflect(_ coordinate: Coordinate, on axis: Axis, at point: Coordinate) -> Coordinate {
        
        switch axis {
        case .horizontal:
            let distance = point.x - coordinate.x
            return coordinate.setting(path: \.x, to: point.x + distance)
            
        case .vertical:
            let distance = point.y - coordinate.y
            return coordinate.setting(path: \.y, to: point.y + distance)
        }
    }
}

extension Coordinate {
    
    public func rotated(by amount: DegreeAmount, direction: Direction, about point: Coordinate) -> Coordinate {
        
        return Coordinate.rotate(self, by: amount, direction: direction, about: point)
    }
    
    public static func rotate(_ coordinate: Coordinate, by amount: DegreeAmount, direction: Direction, about origin: Coordinate) -> Coordinate {
        
        switch amount {
        case .quarter:
            
            let theta = amount.angle(direction: direction)
            
            let x = (cos(theta) * Double(coordinate.x - origin.x) - sin(theta) * Double(coordinate.y - origin.y) + Double(origin.x))
            let y = (sin(theta) * Double(coordinate.x - origin.x) - cos(theta) * Double(coordinate.y - origin.y) + Double(origin.y))
            
            return Coordinate(x: Int(round(x)), y: Int(round(y)))
            
        case .half:
            let quarter = rotate(coordinate, by: .quarter, direction: direction, about: origin)
            return rotate(quarter, by: .quarter, direction: direction, about: origin)
        }
    }
}
