//
//  Sequence+Convenience.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

extension Sequence {
    
    public func setMap<T: Hashable>(transform: (Element) throws -> T) rethrows -> Set<T> {
        
        return try lazy.map(transform)
            .reduce(Set<T>()) { set, value in set.inserting(value) }
    }
}

extension Sequence where Element: Hashable {
    
    func toSet() -> Set<Element> {
        
        return setMap { $0 }
    }
}
