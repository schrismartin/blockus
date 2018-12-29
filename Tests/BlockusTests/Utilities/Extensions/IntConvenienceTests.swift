//
//  IntConvenienceTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import XCTest
@testable import Blockus

class IntConvenienceTests: XCTestCase {
    
    static let allTests = [
        ("testIncrement", testIncrement),
        ("testDecrement", testDecrement),
    ]

    func testIncrement() {
        
        for _ in 0 ..< 1000 {
            let random = Int.random(in: .min ..< .max)
            XCTAssertEqual(Int.incr(random), random + 1)
        }
        
        XCTAssertEqual(Int.incr(.min), .min + 1)
        XCTAssertEqual(Int.incr(.max), .max)
    }
    
    func testDecrement() {
        
        for _ in 0 ..< 1000 {
            let random = Int.random(in: .min + 1 ... .max)
            XCTAssertEqual(Int.decr(random), random - 1)
        }
        
        XCTAssertEqual(Int.decr(.min), .min)
        XCTAssertEqual(Int.decr(.max), .max - 1)
    }
}
