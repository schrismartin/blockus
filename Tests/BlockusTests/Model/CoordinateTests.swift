//
//  CoordinateTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//  Copyright © 2018 Chris Martin. All rights reserved.
//

import XCTest
@testable import Blockus

class CoordinateTests: XCTestCase {
    
    static let allTests = [
        ("testOffset", testOffset),
        ("testDirections", testDirections),
        ("testHorizontalReflections", testHorizontalReflections),
        ("testVerticalReflections", testVerticalReflections),
        ("testClockwiseQuarterRotations", testClockwiseQuarterRotations),
        ("testCounterClockwiseQuarterRotations", testCounterClockwiseQuarterRotations),
        ("testHalfRotations", testHalfRotations),
        ("testThreeQuarterRotationsAreEqualToOppositeQuarterRotations", testThreeQuarterRotationsAreEqualToOppositeQuarterRotations),
        ("testRandomCoordinateInRange", testRandomCoordinateInRange),
        ("testRandomCoordinateInSize", testRandomCoordinateInSize),
        ("testDescription", testDescription)
    ]
    
    let base = Coordinate(x: 8, y: -6)

    func testOffset() {
        
        XCTAssertEqual(base.offset(by: Coordinate(x: -1, y: -1)), Coordinate(x: 7, y: -7))
        XCTAssertEqual(base.offset(by: Coordinate(x: -1, y: 0)), Coordinate(x: 7, y: -6))
        XCTAssertEqual(base.offset(by: Coordinate(x: -1, y: 1)), Coordinate(x: 7, y: -5))
        XCTAssertEqual(base.offset(by: Coordinate(x: 0, y: -1)), Coordinate(x: 8, y: -7))
        XCTAssertEqual(base.offset(by: Coordinate(x: 0, y: 0)), Coordinate(x: 8, y: -6))
        XCTAssertEqual(base.offset(by: Coordinate(x: 0, y: 1)), Coordinate(x: 8, y: -5))
        XCTAssertEqual(base.offset(by: Coordinate(x: 1, y: -1)), Coordinate(x: 9, y: -7))
        XCTAssertEqual(base.offset(by: Coordinate(x: 1, y: 0)), Coordinate(x: 9, y: -6))
        XCTAssertEqual(base.offset(by: Coordinate(x: 1, y: 1)), Coordinate(x: 9, y: -5))
    }
    
    func testDirections() {
        
        XCTAssertEqual(base.above, Coordinate(x: 8, y: -7))
        XCTAssertEqual(base.below, Coordinate(x: 8, y: -5))
        XCTAssertEqual(base.left, Coordinate(x: 7, y: -6))
        XCTAssertEqual(base.right, Coordinate(x: 9, y: -6))
        XCTAssertEqual(base.upperLeft, Coordinate(x: 7, y: -7))
        XCTAssertEqual(base.upperRight, Coordinate(x: 9, y: -7))
        XCTAssertEqual(base.lowerLeft, Coordinate(x: 7, y: -5))
        XCTAssertEqual(base.lowerRight, Coordinate(x: 9, y: -5))
    }
    
    func testHorizontalReflections() {
        
        XCTAssertEqual(base.reflected(on: .horizontal, at: .zero),Coordinate(x: -8, y: -6))
        
        XCTAssertEqual(base.reflected(on: .horizontal, at: Coordinate(x: 3, y: 3)),Coordinate(x: -2, y: -6))
    }
    
    func testVerticalReflections() {
        
        XCTAssertEqual(base.reflected(on: .vertical, at: .zero),Coordinate(x: 8, y: 6))
        
        XCTAssertEqual(base.reflected(on: .vertical, at: Coordinate(x: 3, y: 3)),Coordinate(x: 8, y: 12))
    }
    
    func testClockwiseQuarterRotations() {
        
        XCTAssertEqual(
            base.rotated(by: .quarter, about: .zero),
            Coordinate(x: 6, y: 8)
        )
        
        XCTAssertEqual(
            base.rotated(by: .quarter, about: Coordinate(x: 1, y: 1)),
            Coordinate(x: 8, y: 8)
        )
    }
    
    func testCounterClockwiseQuarterRotations() {
        
        XCTAssertEqual(
            base.rotated(by: .threeQuarters, about: .zero),
            Coordinate(x: -6, y: -8)
        )
        
        XCTAssertEqual(
            base.rotated(by: .threeQuarters, about: Coordinate(x: 1, y: 1)),
            Coordinate(x: -6, y: -6)
        )
    }
    
    func testHalfRotations() {
        
        XCTAssertEqual(
            base.rotated(by: .half, about: .zero),
            Coordinate(x: -8, y: 6)
        )
        
        XCTAssertEqual(
            base.rotated(by: .half, about: Coordinate(x: 1, y: 1)),
            Coordinate(x: -6, y: 8)
        )
    }
    
    func testThreeQuarterRotationsAreEqualToOppositeQuarterRotations() {
        
        for _ in 0 ..< 10000 {
            let coord = Coordinate.random(in: -1000 ..< 1000)
            let pivot = Coordinate.random(in: -1000 ..< 1000)
            
            XCTAssertEqual(
                coord
                    .rotated(by: .quarter, about: pivot)
                    .rotated(by: .quarter, about: pivot)
                    .rotated(by: .quarter, about: pivot),
                coord.rotated(by: .threeQuarters, about: pivot)
            )
        }
    }
    
    func testRandomCoordinateInRange() {
        
        for _ in 0 ..< 1000 {
            let coordinate = Coordinate.random(in: -50 ..< 50)
            XCTAssertTrue((-50 ..< 50).contains(coordinate.x))
            XCTAssertTrue((-50 ..< 50).contains(coordinate.y))
        }
    }
    
    func testRandomCoordinateInSize() {
        
        for _ in 0 ..< 1000 {
            let coordinate = Coordinate.random(in: Size(width: 60, height: 80))
            XCTAssertTrue((0 ..< 60).contains(coordinate.x))
            XCTAssertTrue((0 ..< 80).contains(coordinate.y))
        }
    }
    
    func testDescription() {
        
        XCTAssertEqual(Coordinate(x: 1, y: 2).description, "(x: 1, y: 2)")
        XCTAssertEqual(Coordinate(x: -1, y: -2).description, "(x: -1, y: -2)")
    }
}
