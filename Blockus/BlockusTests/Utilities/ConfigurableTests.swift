//
//  ConfigurableTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import XCTest
@testable import Blockus

class ConfigurableTests: XCTestCase {

    struct Item: Configurable { var property: Int = 0 }
    
    class ClassItem { var property: Int = 0 }
    class SubclassItem: ClassItem, Configurable { var otherProperty: Int = 0 }
    
    func testConfigurationOnStruct() {
        
        for _ in 0 ..< 50 {
            let random = Int.random(in: Int.min ... Int.max)
            let item = Item().configured { item in
                item.property = random
            }
            
            XCTAssertEqual(item.property, random)
        }
    }
    
    func testConfigurationOnClass() {
        
        for _ in 0 ..< 50 {
            let random = Int.random(in: Int.min ... Int.max)
            let item = SubclassItem().configured { item in
                item.property = random
                item.otherProperty = random
            }
            
            XCTAssertEqual(item.property, random)
        }
    }
    
    func testMultipleSetsTriggerDidSetOnce() {
        
        var numberOfSets = 0
        
        var item = Item() {
            didSet { numberOfSets += 1 }
        }
        
        XCTAssertEqual(numberOfSets, 0)
        XCTAssertEqual(item.property, 0)
        
        item = (0 ..< 100).reduce(item) { item, iteration in
            item.configured { $0.property = iteration }
        }
        
        XCTAssertEqual(numberOfSets, 1)
        XCTAssertEqual(item.property, 99)
    }
}
