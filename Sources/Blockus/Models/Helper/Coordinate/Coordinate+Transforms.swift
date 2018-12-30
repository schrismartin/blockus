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
            
            let theta = amount.angle
            
            let x = (cos(theta) * Double(self.x - origin.x) - sin(theta) * Double(self.y - origin.y) + Double(origin.x))
            let y = (sin(theta) * Double(self.x - origin.x) - cos(theta) * Double(self.y - origin.y) + Double(origin.y))
            
            return Coordinate(x: Int(round(x)), y: Int(round(y)))
            
        case .half:
            let quarter = rotated(by: .quarter, about: origin)
            return quarter.rotated(by: .quarter, about: origin)
            
        case .full:
            return self
        }
    }
}
