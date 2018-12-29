//
//  Settable.swift
//  Blockus
//
//  Created by Chris Martin on 12/26/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

public protocol Settable {}

extension Settable {
    public func setting<Value>(path keyPath: WritableKeyPath<Self, Value>, to value: Value) -> Self {
        
        var mutableSelf = self
        mutableSelf[keyPath: keyPath] = value
        return mutableSelf
    }
    
    public func setting<Value>(path keyPath: WritableKeyPath<Self, Value>, using modification: (Value) -> Value) -> Self {
        
        return setting(path: keyPath, to: modification(self[keyPath: keyPath]))
    }
}
