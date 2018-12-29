//
//  Set+Convenience.swift
//  Blockus
//
//  Created by Chris Martin on 12/28/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import Foundation

extension Set {
    
    func inserting(_ newMember: Element) -> Set<Element> {
        
        var set = self
        set.insert(newMember)
        return set
    }
    
    func removing(_ member: Element) -> Set<Element> {
        
        var set = self
        set.remove(member)
        return set
    }
}
