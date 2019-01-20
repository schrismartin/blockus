//
//  PlacedPiece.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

public struct PlacedPiece: TransformableCoordinateContainer {

    public var piece: Piece
    public var origin: Coordinate
    public var transforms: TransformCollection
    
    public init(piece: Piece, origin: Coordinate, transforms: TransformCollection) {
        
        self.piece = piece
        self.origin = origin
        self.transforms = transforms
    }
    
    public init(piece: Piece, center: Coordinate, transforms: TransformCollection) {
        
        self.init(
            piece: piece,
            origin: Coordinate(
                x: center.x - piece.size.center.x,
                y: center.y - piece.size.center.y
            ),
            transforms: transforms
        )
    }
    
    public var coordinates: Coordinates {
        
        let transforms = self.transforms
            .adding(.offset(by: origin))
        
        return piece.coordinates
            .applying(transforms: transforms)
    }
    
    var tiles: [Coordinate: Color] {
        
        return coordinates
            .reduce([Coordinate: Color]()) { $0.inserting(value: piece.color, at: $1) }
    }
    
    public func applying(transform: Transform) -> PlacedPiece {
        
        return setting(path: \.transforms) { transforms in
            transforms.adding(transform)
        }
    }
}

extension PlacedPiece: TileCollection {
    
    public func tile(at coordinate: Coordinate) -> Color? {
        return coordinates.contains(coordinate) ? piece.color : nil
    }
}
