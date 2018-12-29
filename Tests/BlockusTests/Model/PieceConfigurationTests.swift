//
//  PieceConfigurationTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//

import XCTest
@testable import Blockus

class PieceConfigurationTests: XCTestCase {

    static let allTests = [
        ("testOneLineInitializer", testOneLineInitializer),
        ("testMultiLineInitializer", testMultiLineInitializer),
        ("testInitializationWithLeadingHorizontalSpace", testInitializationWithLeadingHorizontalSpace),
        ("testInitializationWithLeadingVerticalSpace", testInitializationWithLeadingVerticalSpace),
    ]

    func testOneLineInitializer() {
        
        XCTAssertEqual(
            PieceConfiguration(stringLiteral: "XXX").coordinates,
            [
                Coordinate(x: 0, y: 0),
                Coordinate(x: 1, y: 0),
                Coordinate(x: 2, y: 0),
            ]
        )
    }
    
    func testMultiLineInitializer() {
        
        XCTAssertEqual(
            PieceConfiguration(stringLiteral: "X\nX\nX").coordinates,
            [
                Coordinate(x: 0, y: 0),
                Coordinate(x: 0, y: 1),
                Coordinate(x: 0, y: 2),
            ]
        )
    }
    
    func testInitializationWithLeadingHorizontalSpace() {
        
        XCTAssertEqual(
            PieceConfiguration(stringLiteral: " X\n X\n X").coordinates,
            [
                Coordinate(x: 0, y: 0),
                Coordinate(x: 0, y: 1),
                Coordinate(x: 0, y: 2),
            ]
        )
    }
    
    func testInitializationWithLeadingVerticalSpace() {
        
        XCTAssertEqual(
            PieceConfiguration(stringLiteral: "   \nXXX").coordinates,
            [
                Coordinate(x: 0, y: 0),
                Coordinate(x: 1, y: 0),
                Coordinate(x: 2, y: 0),
            ]
        )
    }
}
