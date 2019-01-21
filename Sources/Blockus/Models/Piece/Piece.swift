//
//  Piece.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public struct Piece {
    
    public var config: PieceConfiguration
    public let size: Size
    public let numberOfPieces: Int
    public let color: Color
    
    public var coordinates: Coordinates {
        return config.coordinates
    }
    
    public init(config: PieceConfiguration, color: Color) {
        
        self.config = config
        self.color = color
        
        let coords = config.coordinates
        self.size = Size(from: coords)
        self.numberOfPieces = coords.count
    }
}

extension Piece: TileCollection {
    
    public func tile(at coordinate: Coordinate) -> Color? {
        return coordinates.contains(coordinate) ? color : nil
    }
}

extension Piece: CustomStringConvertible {
    
    public var description: String {
        
        var description = ""
        
        for y in 0 ..< size.height {
            description.append("\n")
            for x in 0 ..< size.width {
                let coord = Coordinate(x: x, y: y)
                let character = coordinates.contains(coord) ? "X" : " "
                description.append(character)
            }
        }
        
        return description
    }
}

extension Piece: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(coordinates)
       _ = hasher.finalize()
    }
    
    public static func == (lhs: Piece, rhs: Piece) -> Bool {
        return lhs.coordinates == rhs.coordinates
    }
}
