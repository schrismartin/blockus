//
//  DegreeAmountTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//

import XCTest
@testable import Blockus

class DegreeAmountTests: XCTestCase {
    
    static let allTests = [
        ("testDegreeAmount", testDegreeAmount)
    ]

    func testDegreeAmount() {
        
        XCTAssertEqual(DegreeAmount.quarter.angle(direction: .clockwise), .pi / 2)
        XCTAssertEqual(DegreeAmount.quarter.angle(direction: .counterClockwise), (.pi * 3) / 2)
        
        XCTAssertEqual(DegreeAmount.half.angle(direction: .clockwise), .pi)
        XCTAssertEqual(DegreeAmount.half.angle(direction: .counterClockwise), .pi)
    }
}
