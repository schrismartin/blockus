//
//  Array+Convenience.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

extension Collection {
    
    public func at(index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

extension Array {
    
    public func appending(_ member: Element) -> Array {
        
        var mutableSelf = self
        mutableSelf.append(member)
        return mutableSelf
    }
}

extension Array where Element: Equatable {
    
    public func range(of subCollection: Array<Element>) -> Range<Index>? {
        
        for index in indices {
            let endIndex = self.index(index, offsetBy: subCollection.count, limitedBy: self.endIndex) ?? self.endIndex
            
            let range = Range<Index>(uncheckedBounds: (index, endIndex))
            
            if Array(self[range]) == subCollection {
                return range
            }
        }
        
        return nil
    }
}
