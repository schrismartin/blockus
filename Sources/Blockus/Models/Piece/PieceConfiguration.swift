//
//  PieceConfiguration.swift
//  Blockus
//
//  Created by Chris Martin on 12/27/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public enum PieceConfiguration: String, CaseIterable {
    
    case one = "X"
    case two = "XX"
    case corner = "XX\n X"
    case three = "XXX"
    case square = "XX\nXX"
    case finger = " X \nXXX"
    case four = "XXXX"
    case smallL = "  X\nXXX"
    case zag = " XX\nXX"
    case longL = "X\nXXXX"
    case longFinger = " X \n X \nXXX"
    case bigL = "X\nX\nXXX"
    case longZag = " XXX\nXX"
    case wave = "  X\nXXX\nX"
    case five = "XXXXX"
    case thumb = "X\nXX\nXX"
    case stairs = " XX\nXX\nX"
    case c = "XX\nX\nXX"
    case awkward = " XX\nXX\n X"
    case plus = " X \nXXX\n X "
    case mummy = " X\nXXXX"
    
    var coordinates: Coordinates {
        
        var coordinates = Coordinates()
        
        for (y, line) in rawValue.split(separator: "\n").enumerated() {
            for (x, tile) in line.enumerated() where tile != " " {
                let coord = Coordinate(x: x, y: y)
                coordinates.insert(coord)
            }
        }
        
        return normalize(coordinates)
    }
}

extension PieceConfiguration: Hashable { }
