//
//  Transformable.swift
//  Blockus
//
//  Created by Chris Martin on 1/1/19.
//

import Foundation

typealias TransformableCoordinateContainer = Transformable & CoordinateContainer

protocol Transformable {
    
    func applying(transform: Transform) -> Self
}

extension Transformable {
    
    func applying(transforms: TransformCollection) -> Self {
        
        return transforms.transforms.reduce(self) { container, transform in
            container.applying(transform: transform)
        }
    }
}
