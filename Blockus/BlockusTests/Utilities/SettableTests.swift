//
//  SettableTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import XCTest
@testable import Blockus

class SettableTests: XCTestCase {
    
    struct Item: Settable {
        var property: Int = 0
    }

    func testSingleValuePropertyIsSet() {
        
        for _ in 0 ..< 50 {
            let random = Int.random(in: Int.min ... Int.max)
            let item = Item().setting(path: \.property, to: random)
            XCTAssertEqual(item.property, random)
        }
    }
    
    func testClosurePropertyIsSet() {
        
        for _ in 0 ..< 50 {
            let random = Int.random(in: Int.min ... Int.max)
            let item = Item().setting(path: \.property) { $0 - random }
            XCTAssertEqual(item.property, -random)
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
            item.setting(path: \.property, to: iteration)
        }
        
        XCTAssertEqual(numberOfSets, 1)
        XCTAssertEqual(item.property, 99)
    }
}
