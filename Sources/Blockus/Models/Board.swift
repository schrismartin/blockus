//
//  Board.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public struct Board: Settable, Configurable {
    
    private var grid: [[Tile]]
    public let size: Size
    
    public init(size: Size = Size(width: 20, height: 20)) {
        
        self.size = size
        
        grid = [[Tile]](
            repeating: [Tile](
                repeating: .blank,
                count: size.width
            ),
            count: size.height
        )
    }
    
    public func tile(at coordinate: Coordinate) throws -> Tile {
        
        try Board.validate(coordinate: coordinate, existsOn: self)
        return grid[coordinate.x][coordinate.y]
    }
    
    public var coordinates: Coordinates {
        return Set((0 ..< size.width)
            .flatMap { x in (0 ..< size.height).setMap { y in Coordinate(x: x, y: y) } })
    }
    
    public func indexedTiles() -> [(coord: Coordinate, tile: Tile)] {
        return grid.enumerated().flatMap { column in
            column.element.enumerated().map { tile in (Coordinate(x: column.offset, y: tile.offset), tile.element) }
        }
    }
}

extension Board {
    
    public static func validate(coordinate: Coordinate, existsOn board: Board) throws {
        
        guard coordinate.x < board.size.width && coordinate.y < board.size.height else {
            throw Error.invalidCoordinate(coordinate)
        }
    }
    
    public static func validate(coordinate: Coordinate, isVacantOn board: Board) throws {
        
        let tile = try board.tile(at: coordinate)
        switch tile {
        case .occupied(let color):
            throw Error.itemExists(color: color, coord: coordinate)
        case .blank:
            break
        }
    }
}

extension Board {
    
    public func placeTile(of color: Color, at coordinate: Coordinate) throws -> Board {
        
        try Board.validate(coordinate: coordinate, existsOn: self)
        try Board.validate(coordinate: coordinate, isVacantOn: self)
        return self.setting(path: \.grid[coordinate.x][coordinate.y], to: .occupied(color))
    }
    
    public func remoteTile(at coordinate: Coordinate) throws -> Board {
        
        try Board.validate(coordinate: coordinate, existsOn: self)
        return self.setting(path: \.grid[coordinate.x][coordinate.y], to: .blank)
    }
    
    public func place(piece: Piece, at coordinate: Coordinate) throws -> Board {
        
        return try piece.coordinates
            .map { $0.offset(by: coordinate) }
            .reduce(self) { board, coord in try board.placeTile(of: piece.color, at: coord) }
    }
}

extension Board {
    
    public enum Error: Swift.Error {
        case itemExists(color: Color, coord: Coordinate)
        case invalidCoordinate(Coordinate)
    }
}
