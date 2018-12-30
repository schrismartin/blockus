//
//  TransformCollection.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

public struct TransformCollection: Settable {
    
    var transforms: [Transform]
    
    public init() {
        transforms = []
    }
    
    public func mirrored(on axis: Axis) -> TransformCollection {
        return adding(.mirrored(axis: axis))
    }
    
    public func rotated(amount: Rotation) -> TransformCollection {
        return adding(.rotated(amount: amount))
    }
    
    func adding(_ transform: Transform) -> TransformCollection {
        return self.setting(path: \TransformCollection.transforms) { transforms in
            transforms.appending(transform)
        }
    }
}

extension TransformCollection: ExpressibleByNilLiteral {
    
    public init(nilLiteral: ()) {
        self.init()
    }
    
    public static func mirrored(on axis: Axis) -> TransformCollection {
        return TransformCollection().mirrored(on: axis)
    }
    
    public static func rotated(amount: Rotation) -> TransformCollection {
        return TransformCollection().rotated(amount: amount)
    }
}
