//
//  DegreeAmount.swift
//  Blockus
//
//  Created by Chris Martin on 12/27/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public enum Rotation {
    case quarter
    case half
    case threeQuarters
    case full
    
    var angle: Double {
        
        switch self {
        case .full:
            return 0
        case .quarter:
            return .pi / 2
        case .half:
            return .pi
        case .threeQuarters:
            return (.pi * 3) / 2
        }
    }
}
