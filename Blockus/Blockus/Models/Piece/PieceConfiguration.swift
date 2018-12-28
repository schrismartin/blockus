//
//  PieceConfiguration.swift
//  Blockus
//
//  Created by Chris Martin on 12/27/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public struct PieceConfiguration: ExpressibleByStringLiteral {
    
    private(set) public var coordinates = [Coordinate]()
    
    public init(string: String) {
        
        for (y, line) in string.split(separator: "\n").enumerated() {
            for (x, tile) in line.enumerated() where tile != " " {
                let coord = Coordinate(x: x, y: y)
                coordinates.append(coord)
            }
        }
    }
    
    public init(stringLiteral string: String) {
        
        self.init(string: string)
    }
}

extension PieceConfiguration {
    
    public static let one: PieceConfiguration = "X"
    public static let two: PieceConfiguration = "XX"
    public static let corner: PieceConfiguration = "XX\n X"
    public static let three: PieceConfiguration = "XXX"
    public static let square: PieceConfiguration = "XX\nXX"
    public static let finger: PieceConfiguration = " X \nXXX"
    public static let four: PieceConfiguration = "XXXX"
    public static let smallL: PieceConfiguration = "  X\nXXX"
    public static let zag: PieceConfiguration = " XX\nXX"
    public static let longL: PieceConfiguration = "X\nXXXX"
    public static let longFinger: PieceConfiguration = " X \n X \nXXX"
    public static let bigL: PieceConfiguration = "X\nX\nXXX"
    public static let longZag: PieceConfiguration = " XXX\nXX"
    public static let wave: PieceConfiguration = "  X\nXXX\nX"
    public static let five: PieceConfiguration = "XXXXX"
    public static let thumb: PieceConfiguration = "X\nXX\nXX"
    public static let stairs: PieceConfiguration = " XX\nXX\nX"
    public static let c: PieceConfiguration = "XX\nX\nXX"
    public static let awkward: PieceConfiguration = " XX\nXX\n X"
    public static let plus: PieceConfiguration = " X \nXXX\n X "
    public static let mummy: PieceConfiguration = " X\nXXXX"
}
