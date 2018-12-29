//
//  SizeTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import XCTest
@testable import Blockus

class SizeTests: XCTestCase {

    func testInitializer() {
        
        let size = Size(width: 10, height: 16)
        XCTAssertEqual(size.height, 16)
        XCTAssertEqual(size.width, 10)
    }
    
    func testRelations() {
        
        let size = Size(width: 10, height: 16)
        XCTAssertEqual(size.topLeft, Coordinate(x: 0, y: 0))
        XCTAssertEqual(size.topRight, Coordinate(x: 9, y: 0))
        XCTAssertEqual(size.bottomLeft, Coordinate(x: 0, y: 15))
        XCTAssertEqual(size.bottomRight, Coordinate(x: 9, y: 15))
    }
    
    func testCenterEvenDimensions() {
        
        let size = Size(width: 10, height: 16)
        XCTAssertEqual(size.center, Coordinate(x: 5, y: 8))
    }
    
    func testCenterOddDimensions() {
        
        let size = Size(width: 9, height: 15)
        XCTAssertEqual(size.center, Coordinate(x: 4, y: 7))
    }
}
