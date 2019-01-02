//
//  Board.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public struct Board {
    
    public let size: Size
    public var pieces: [PlacedPiece]
    
    var tiles: [Coordinate: Color] = [:]
    
    public init(size: Size = Size(width: 20, height: 20)) {
        
        self.size = size
        self.pieces = []
    }
    
    public func tile(at coordinate: Coordinate) -> Color? {
        
        return tiles[coordinate]
    }
}

extension Board: CoordinateContainer {
    
    public var coordinates: Coordinates {
        return pieces
            .flatMap { $0.coordinates }
            .toSet()
    }
    
    public func availableMoves(for color: Color) -> Coordinates {
        
        return Set(pieces(of: color)
            .flatMap { $0.coordinates.availableMoves }
            .toSet()
            .lazy
            .filter { coord in self.tile(at: coord) == nil }
            .filter { coord in self.size.contains(point: coord) })
    }
    
    func pieces(of color: Color) -> [PlacedPiece] {
        
        return pieces.filter { $0.piece.color == color }
    }
}

extension Board {
    
    public static func validate(coordinate: Coordinate, existsOn board: Board) throws {
        
        guard coordinate.x < board.size.width && coordinate.y < board.size.height else {
            throw Error.invalidCoordinate(coordinate)
        }
    }
    
    public static func validate(coordinate: Coordinate, isVacantOn board: Board) throws {
        
        if let color = board.tile(at: coordinate) {
            throw Error.itemExists(color: color, coord: coordinate)
        }
    }
}

extension Board {
    
    public func place(piece: Piece, at coordinate: Coordinate, transforms: TransformCollection = nil) throws -> Board {
        
        let placedPiece = PlacedPiece(
            piece: piece,
            origin: coordinate,
            transforms: transforms
        )
        
        let tiles = placedPiece.tiles
        
        try tiles.keys.forEach { coord in try Board.validate(coordinate: coord, isVacantOn: self) }
        
        return self
            .setting(path: \Board.pieces) { pieces in pieces.appending(placedPiece) }
            .setting(path: \Board.tiles) { tiles in tiles.merging(placedPiece.tiles) { color, _ in color } }
    }
}

extension Board {
    
    public enum Error: Swift.Error {
        case itemExists(color: Color, coord: Coordinate)
        case invalidCoordinate(Coordinate)
    }
}
