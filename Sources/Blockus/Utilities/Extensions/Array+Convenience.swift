//
//  Array+Convenience.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

extension Array {
    
    public func appending(_ member: Element) -> Array {
        
        var mutableSelf = self
        mutableSelf.append(member)
        return mutableSelf
    }
}
