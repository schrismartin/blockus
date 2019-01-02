//
//  Dictionary+Convenience.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

extension Dictionary {
    
    public func inserting(value: Value, at key: Key) -> Dictionary<Key, Value> {
        
        var mutableSelf = self
        mutableSelf[key] = value
        return mutableSelf
    }
}
