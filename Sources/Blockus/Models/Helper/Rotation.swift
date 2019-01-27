//
//  DegreeAmount.swift
//  Blockus
//
//  Created by Chris Martin on 12/27/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public struct Rotation: Equatable, Settable {
    
    var quadrants: Int {
        didSet { quadrants = quadrants % 4 }
    }
    
    var clockwise: Rotation {
        return setting(path: \.quadrants) { prev in (prev + 1) % 4 }
    }
    
    var counterClockwise: Rotation {
        return setting(path: \.quadrants) { prev in (prev + 3) % 4 }
    }
    
    var angle: Double {
        return (Double(quadrants) * .pi) / 2
    }
}

extension Rotation {
    
    public static let full = Rotation(quadrants: 0)
    public static let quarter = Rotation(quadrants: 1)
    public static let half = Rotation(quadrants: 2)
    public static let threeQuarters = Rotation(quadrants: 3)
}
