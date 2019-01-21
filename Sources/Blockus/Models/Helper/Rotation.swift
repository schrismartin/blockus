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
    
    var clockwise: Rotation {
        switch self {
        case .full: return .quarter
        case .quarter: return .half
        case .half: return .threeQuarters
        case .threeQuarters: return .full
        }
    }
    
    var counterClockwise: Rotation {
        switch self {
        case .full: return .threeQuarters
        case .threeQuarters: return .half
        case .half: return .quarter
        case .quarter: return .full
        }
    }
    
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
