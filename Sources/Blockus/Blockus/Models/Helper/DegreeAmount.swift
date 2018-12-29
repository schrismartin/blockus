//
//  DegreeAmount.swift
//  Blockus
//
//  Created by Chris Martin on 12/27/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public enum DegreeAmount {
    case quarter
    case half
    
    func angle(direction: Direction) -> Double {
        
        switch (self, direction) {
        case (.quarter, .clockwise):
            return .pi / 2
        case (.half, _):
            return DegreeAmount.quarter.angle(direction: .clockwise) * 2
        case (.quarter, .counterClockwise):
            return DegreeAmount.quarter.angle(direction: .clockwise) * 3
        }
    }
}
