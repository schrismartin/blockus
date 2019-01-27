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
    
    public func setting<Value>(path keyPath: WritableKeyPath<Self, Value>, using modification: (Value) throws -> Value) rethrows -> Self {
        
        return setting(path: keyPath, to: try modification(self[keyPath: keyPath]))
    }
    
    public func setting<Value>(path keyPath: WritableKeyPath<Self, Value>, using modification: (inout Value) throws -> Void) rethrows -> Self {
        
        var mutableSelf = self
        try modification(&mutableSelf[keyPath: keyPath])
        return mutableSelf
    }
}

extension Set: Settable { }
