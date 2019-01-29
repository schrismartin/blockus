//
//  Coordinate+Transforms.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

extension Coordinate {
    
    public func offset(by offset: Coordinate) -> Coordinate {
        return self
            .setting(path: \.x) { x in x + offset.x }
            .setting(path: \.y) { y in y + offset.y }
    }
    
    public func reflected(on axis: Axis, at point: Coordinate) -> Coordinate {
        
        switch axis {
        case .horizontal:
            let distance = point.x - x
            return setting(path: \.x, to: point.x + distance)
            
        case .vertical:
            let distance = point.y - y
            return setting(path: \.y, to: point.y + distance)
        }
    }
    
    public func rotated(by amount: Rotation, about origin: Coordinate) -> Coordinate {
        
        switch amount {
        case .quarter, .threeQuarters:
            
            return Coordinate(
                x: Int(solve(for: .horizontal, origin: origin, theta: amount.angle)),
                y: Int(solve(for: .vertical, origin: origin, theta: amount.angle))
            )
            
        case .half:
            let quarter = rotated(by: .quarter, about: origin)
            return quarter.rotated(by: .quarter, about: origin)
            
        case .full:
            return self
        default:
            fatalError("Invalid rotation \(amount) provided to rotation function.")
        }
    }
    
    private func solve(for axis: Axis, origin: Coordinate, theta: Double) -> Double {
        let solver: (x: (Double) -> Double, y: (Double) -> Double)
        let offset: Double
        
        switch axis {
        case .horizontal:
            solver = (cos, sin)
            offset = Double(origin.x)
        case .vertical:
            solver = (sin, cos)
            offset = Double(origin.y)
        }
        
        return round(
            solver.x(theta) * Double(self.x - origin.x) -
            solver.y(theta) * Double(self.y - origin.y) +
            offset
        )
    }
}
