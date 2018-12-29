//
//  TileTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//

import XCTest
@testable import Blockus

class TileTests: XCTestCase {
    
    static let allTests = [
        ("testColor", testColor)
    ]

    func testColor() {
        
        XCTAssertEqual(Tile.occupied(.blue).color, .blue)
        XCTAssertEqual(Tile.occupied(.green).color, .green)
        XCTAssertEqual(Tile.occupied(.red).color, .red)
        XCTAssertEqual(Tile.occupied(.yellow).color, .yellow)
        XCTAssertEqual(Tile.blank.color, nil)
    }
}
