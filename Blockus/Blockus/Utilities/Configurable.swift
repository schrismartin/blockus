//
//  Configurable.swift
//  Blockus
//
//  Created by Chris Martin on 12/28/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public protocol Configurable {}

extension Configurable {
    
    public func configured(handler: @escaping (Self) throws -> Self) rethrows -> Self {
        
        return try handler(self)
    }
}
