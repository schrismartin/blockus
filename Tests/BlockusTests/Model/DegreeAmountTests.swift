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
        
        XCTAssertEqual(Rotation.quarter.angle, .pi / 2)
        XCTAssertEqual(Rotation.half.angle, .pi)
        XCTAssertEqual(Rotation.threeQuarters.angle, (.pi * 3) / 2)
        XCTAssertEqual(Rotation.full.angle, 0)
    }
}
