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
    
    public func startingPoint(for color: Color) -> Coordinate {
        
        switch color {
        case .blue: return size.topLeft
        case .yellow: return size.topRight
        case .red: return size.bottomLeft
        case .green: return size.bottomRight
        }
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
            .inserting(startingPoint(for: color))
            .lazy
            .filter { coord in self.tile(at: coord) == nil }
            .filter { coord in self.size.contains(point: coord) })
    }
    
    public func allCoordinates(for color: Color) -> Coordinates {
        
        return pieces(of: color)
            .flatMap { $0.coordinates }
            .toSet()
    }
    
    func pieces(of color: Color) -> [PlacedPiece] {
        
        return pieces.filter { $0.piece.color == color }
    }
}

extension Board {
    
    public static func validate(piece: PlacedPiece, isValidFor board: Board) throws {
        
        let moves = board.availableMoves(for: piece.piece.color)
        let corners = piece.corners
        let sides = piece.sides
        
        guard !moves.intersection(corners).isEmpty else {
            throw Error.invalidMove(piece: piece.piece, origin: piece.origin, transforms: piece.transforms)
        }
        
        guard board.allCoordinates(for: piece.piece.color).intersection(sides).isEmpty else {
            throw Error.invalidMove(piece: piece.piece, origin: piece.origin, transforms: piece.transforms)
        }
    }
    
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
    
    public func place(piece: Piece, at coordinate: Coordinate, transforms: TransformCollection = .init()) throws -> Board {
        
        let placedPiece = PlacedPiece(
            piece: piece,
            origin: coordinate,
            transforms: transforms
        )
        
        try Board.validate(piece: placedPiece, isValidFor: self)
        
        let tiles = placedPiece.tiles
        
        for coordinate in tiles.keys {
            try Board.validate(coordinate: coordinate, isVacantOn: self)
            try Board.validate(coordinate: coordinate, existsOn: self)
        }
        
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
        case invalidMove(piece: Piece, origin: Coordinate, transforms: TransformCollection)
    }
}

extension Board.Error: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .itemExists(color: let color, coord: let coord):
            return "Item of color \(color) exists on coordinate \(coord)"
        case .invalidCoordinate(let coord):
            return "Coordinate \(coord) does not exist on the board"
        case .invalidMove(piece: let piece, origin: let origin, transforms: _):
            return "Piece cannot be placed at \(origin): \(piece)"
        }
    }
}
