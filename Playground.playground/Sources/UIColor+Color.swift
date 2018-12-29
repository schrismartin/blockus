//
//  UIColor+Color.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import UIKit
import Blockus

extension UIColor {
    
    public static func color(for color: Color) -> UIColor {
        
        switch color {
        case .blue: return .blue
        case .green: return .green
        case .yellow: return .yellow
        case .red: return .red
        }
    }
}
