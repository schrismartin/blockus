//
//  Piece.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public struct Piece: CoordinateContainer {
    
    public var coordinates: Coordinates
    public let size: Size
    public let numberOfPieces: Int
    public let color: Color
    
    public static func random(of size: Size, numberOfPieces: Int, color: Color) -> Piece {
        
        let coordinates = (0 ..< numberOfPieces).reduce(Coordinates()) { set, _ in
            set.inserting(.random(in: size))
        }
        
        return Piece(coordinates: coordinates, color: color)
    }
    
    public init(coordinates: Coordinates, color: Color) {
        
        self.coordinates = coordinates
        self.color = color
        
        size = Size(from: coordinates)
        numberOfPieces = self.coordinates.count
    }
    
    public init(config: PieceConfiguration, color: Color) {
        
        self.init(coordinates: config.coordinates, color: color)
    }
}

extension Piece {
    
    public func calculateAvailableMoves() -> Coordinates {
        
        let corners = coordinates.reduce(Coordinates()) { set, coord in
            set
                .inserting(coord.upperLeft)
                .inserting(coord.upperRight)
                .inserting(coord.lowerLeft)
                .inserting(coord.lowerRight)
        }
        
        return coordinates.reduce(corners) { set, coord in
            set
                .removing(coord)
                .removing(coord.above)
                .removing(coord.below)
                .removing(coord.left)
                .removing(coord.right)
        }
    }
}
