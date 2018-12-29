//
//  Piece.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public struct Piece: Settable {
    
    public var coordinates: Set<Coordinate>
    public let size: Size
    public let numberOfPieces: Int
    public let color: Color
    
    public init(coordinates: [Coordinate], color: Color) {
        
        self.coordinates = Set(coordinates)
        self.color = color
        
        size = Piece.calculateSize(of: coordinates)
        numberOfPieces = self.coordinates.count
    }
    
    public init(config: PieceConfiguration, color: Color) {
        
        self.init(coordinates: config.coordinates, color: color)
    }
    
    public static func calculateSize(of coordinates: [Coordinate]) -> Size {
        let xValues = coordinates.map { $0.x }
        let yValues = coordinates.map { $0.y }
        
        return Size(
            width: (xValues.max() ?? 0) - (xValues.min() ?? 0),
            height: (yValues.max() ?? 0) - (yValues.min() ?? 0)
        )
    }
}

extension Piece {
    
    public func normalized() -> Piece {
        return Piece.normalize(self)
    }
    
    public static func normalize(_ piece: Piece) -> Piece {
        
        let minX = piece.coordinates.map { $0.x }.min() ?? 0
        let minY = piece.coordinates.map { $0.y }.min() ?? 0
        
        let offset = Coordinate(x: -minX, y: -minY)
        return piece.setting(path: \Piece.coordinates) { coords in
            Set(coords.map { $0.offset(by: offset) })
        }
    }
    
    public func mirrored(on axis: Axis) -> Piece {
        return Piece.mirror(self, axis: axis)
    }
    
    public static func mirror(_ piece: Piece, axis: Axis) -> Piece {
        
        let newPiece = piece.setting(path: \Piece.coordinates) { coords in
            Set(coords.map { coord in coord.reflected(on: axis, at: piece.size.center) })
        }
        
        return normalize(newPiece)
    }
    
    public func rotated(by amount: DegreeAmount, direction: Direction) -> Piece {
        return Piece.rotate(self, by: amount, direction: direction)
    }
    
    public static func rotate(_ piece: Piece, by amount: DegreeAmount, direction: Direction) -> Piece {
        
        let newPiece = piece.setting(path: \Piece.coordinates) { coords in
            Set(coords.map { coord in coord.rotated(by: amount, direction: direction, about: piece.size.topLeft) })
        }
        
        return normalize(newPiece)
    }
}

extension Piece {
    
    public func calculateAvailableMoves() -> Set<Coordinate> {
        
        let corners = coordinates.reduce(Set<Coordinate>()) { set, coord in
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
