//
//  SetConvenienceTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import XCTest
@testable import Blockus

class SetConvenienceTests: XCTestCase {
    
    static let allTests = [
        ("testInsertionOfDuplicateValue", testInsertionOfDuplicateValue),
        ("testInsertionOfNewValue", testInsertionOfNewValue),
        ("testRemovingOfExistingValue", testRemovingOfExistingValue),
        ("testRemovingOfNonExistingValue", testRemovingOfNonExistingValue)
    ]
    
    let testSet: Set<Int> = [-10, -1, 0, 1, 10]
    
    func testInsertionOfDuplicateValue() {
        
        XCTAssertEqual(testSet.inserting(-10), testSet)
        XCTAssertEqual(testSet.inserting(-1), testSet)
        XCTAssertEqual(testSet.inserting(0), testSet)
        XCTAssertEqual(testSet.inserting(1), testSet)
        XCTAssertEqual(testSet.inserting(10), testSet)
    }
    
    func testInsertionOfNewValue() {
        
        XCTAssertEqual(testSet.inserting(-11), Set([-11, -10, -1, 0, 1, 10]))
        XCTAssertEqual(testSet.inserting(-9), Set([-9, -10, -1, 0, 1, 10]))
        XCTAssertEqual(testSet.inserting(-2), Set([-2, -10, -1, 0, 1, 10]))
        XCTAssertEqual(testSet.inserting(2), Set([2, -10, -1, 0, 1, 10]))
        XCTAssertEqual(testSet.inserting(9), Set([9, -10, -1, 0, 1, 10]))
        XCTAssertEqual(testSet.inserting(11), Set([11, -10, -1, 0, 1, 10]))
    }
    
    func testRemovingOfExistingValue() {
        
        XCTAssertEqual(testSet.removing(-10), Set([-1, 0, 1, 10]))
        XCTAssertEqual(testSet.removing(-1), Set([-10, 0, 1, 10]))
        XCTAssertEqual(testSet.removing(-0), Set([-10, -1, 1, 10]))
        XCTAssertEqual(testSet.removing(1), Set([-10, -1, 0, 10]))
        XCTAssertEqual(testSet.removing(10), Set([-10, -1, 0, 1, ]))
    }
    
    func testRemovingOfNonExistingValue() {
        
        XCTAssertEqual(testSet.removing(-11), testSet)
        XCTAssertEqual(testSet.removing(-9), testSet)
        XCTAssertEqual(testSet.removing(-2), testSet)
        XCTAssertEqual(testSet.removing(2), testSet)
        XCTAssertEqual(testSet.removing(9), testSet)
        XCTAssertEqual(testSet.removing(11), testSet)
    }
}
