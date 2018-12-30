//
//  CoordinatesTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//

import XCTest
@testable import Blockus

class CoordinatesTests: XCTestCase {
    
    static let allTests = [
        ("testNormalized", testNormalized),
        ("testNormalizedWithNoCoordinates", testNormalizedWithNoCoordinates),
        ("testQuarterRotationClockwise", testQuarterRotationClockwise),
        ("testQuarterRotationCounterClockwise", testQuarterRotationCounterClockwise),
        ("testHalfRotation", testHalfRotation),
        ("testVerticalMirror", testVerticalMirror),
        ("testHorizontalMirror", testHorizontalMirror),
        ("testHorizontalMirrorIsVerticalMirroredHalfRotation", testHorizontalMirrorIsVerticalMirroredHalfRotation),
        ("testVerticalMirrorIsHorizontalMirroredHalfRotation", testVerticalMirrorIsHorizontalMirroredHalfRotation),
    ]
    
    let base = PieceConfiguration(string:
        """
         XXX
          X
         XX
        """
    ).coordinates

    func testNormalized() {
        
        XCTAssertEqual(
            base.normalized(),
            [
                Coordinate(x: 0, y: 0),
                Coordinate(x: 1, y: 0),
                Coordinate(x: 2, y: 0),
                Coordinate(x: 1, y: 1),
                Coordinate(x: 0, y: 2),
                Coordinate(x: 1, y: 2)
            ]
        )
    }
    
    func testNormalizedWithNoCoordinates() {
        
        XCTAssertEqual(Coordinates().normalized(), [])
    }
    
    func testQuarterRotationClockwise() {
        
        let expected = PieceConfiguration(string:
            """
            X X
            XXX
              X
            """
        ).coordinates
        
        XCTAssertEqual(base.rotated(by: .quarter), expected)
    }
    
    func testQuarterRotationCounterClockwise() {
        
        let expected = PieceConfiguration(string:
            """
            X
            XXX
            X X
            """
        ).coordinates
        
        XCTAssertEqual(base.rotated(by: .threeQuarters), expected)
    }
    
    func testHalfRotation() {
        
        let expected = PieceConfiguration(string:
            """
             XX
             X
            XXX
            """
        ).coordinates
        
        XCTAssertEqual(base.rotated(by: .half), expected)
    }
    
    func testVerticalMirror() {
        
        let expected = PieceConfiguration(string:
            """
            XX
             X
            XXX
            """
        ).coordinates
        
        XCTAssertEqual(base.mirrored(on: .vertical), expected)
    }
    
    func testHorizontalMirror() {
        
        let expected = PieceConfiguration(string:
            """
            XXX
             X
             XX
            """
        ).coordinates
        
        XCTAssertEqual(base.mirrored(on: .horizontal), expected)
    }
    
    func testHorizontalMirrorIsVerticalMirroredHalfRotation() {
        
        for _ in 0 ..< 1000 {
            let randomShape = (0 ..< 6).reduce(Coordinates()) { set, _ in
                set.inserting(.random(in: 0 ..< 3))
            }
            
            XCTAssertEqual(
                randomShape.rotated(by: .half).mirrored(on: .vertical),
                randomShape.mirrored(on: .horizontal)
            )
        }
    }
    
    func testVerticalMirrorIsHorizontalMirroredHalfRotation() {
        
        for _ in 0 ..< 1000 {
            let randomShape = (0 ..< 6).reduce(Coordinates()) { set, _ in
                set.inserting(.random(in: 0 ..< 3))
            }
            
            XCTAssertEqual(
                randomShape.rotated(by: .half).mirrored(on: .horizontal),
                randomShape.mirrored(on: .vertical)
            )
        }
    }
}
