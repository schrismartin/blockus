//
//  Tile.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public enum Tile: Equatable {
    case blank
    case occupied(Color)
    
    public var color: Color? {
        guard case let .occupied(color) = self else { return nil }
        return color
    }
}
