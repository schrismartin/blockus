//
//  Int+Convenience.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

extension Int {
    public static func incr(_ x: Int) -> Int {
        guard x != .max else { return .max }
        return x + 1
    }
    
    public static func decr(_ x: Int) -> Int {
        guard x != .min else { return .min }
        return x - 1
    }
}
