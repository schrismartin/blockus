//
//  LazyCachedValue.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

struct LazyCachedValue<ValueType> {
    
    typealias Creator = () -> ValueType
    let creator: Creator
    
    private var cashedValue: ValueType?
    
    mutating func value() -> ValueType {
        
        let value = cashedValue ?? creator()
        self.cashedValue = value
        return value
    }
    
    init(creator: @escaping Creator) {
        
        self.creator = creator
    }
    
    init(value: @escaping @autoclosure () -> ValueType) {
        
        self.creator = value
    }
    
    mutating func invalidate() {
        
        cashedValue = nil
    }
}
