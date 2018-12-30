//
//  PlacedPiece.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

public struct PlacedPiece {
    
    public var piece: Piece
    public var origin: Coordinate
    public var transforms: TransformCollection
    
    init(piece: Piece, origin: Coordinate, transforms: TransformCollection) {
        
        self.piece = piece
        self.origin = origin
        self.transforms = transforms
    }
    
    var tiles: [Coordinate: Color] {
        
        return piece.coordinates
            .applying(transforms: transforms)
            .offset(by: origin)
            .reduce([Coordinate: Color]()) { $0.inserting(value: piece.color, at: $1) }
    }
}
