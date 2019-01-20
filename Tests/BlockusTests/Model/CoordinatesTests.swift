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
        ("testAvailableMoveCalculation", testAvailableMoveCalculation),
    ]
    
    struct MockPiece: PieceConfigurationRepresentable {
        
        let stringValue: String
        
        init(string: String) {
            self.stringValue = string
        }
    }
    
    let base = MockPiece(string:
        """
         XXX
          X
         XX
        """
    ).coordinates

    func testNormalized() {
        
        XCTAssertEqual(
            normalize(base),
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
        
        XCTAssertEqual(normalize(Coordinates()), [])
    }
    
    func testQuarterRotationClockwise() {
        
        let expected = MockPiece(string:
            """
            X X
            XXX
              X
            """
        ).coordinates
        
        XCTAssertEqual(rotate(base, by: .quarter), expected)
    }
    
    func testQuarterRotationCounterClockwise() {
        
        let expected = MockPiece(string:
            """
            X
            XXX
            X X
            """
        ).coordinates
        
        XCTAssertEqual(rotate(base, by: .threeQuarters), expected)
    }
    
    func testHalfRotation() {
        
        let expected = MockPiece(string:
            """
             XX
             X
            XXX
            """
        ).coordinates
        
        XCTAssertEqual(rotate(base, by: .half), expected)
    }
    
    func testVerticalMirror() {
        
        let expected = MockPiece(string:
            """
            XX
             X
            XXX
            """
        ).coordinates
        
        XCTAssertEqual(mirror(base, on: .vertical), expected)
    }
    
    func testHorizontalMirror() {
        
        let expected = MockPiece(string:
            """
            XXX
             X
             XX
            """
        ).coordinates
        
        XCTAssertEqual(mirror(base, on: .horizontal), expected)
    }
    
    func testHorizontalMirrorIsVerticalMirroredHalfRotation() {
        
        for _ in 0 ..< 1000 {
            let randomShape = (0 ..< 6).reduce(Coordinates()) { set, _ in
                set.inserting(.random(in: 0 ..< 3))
            }
            
            XCTAssertEqual(
                mirror(rotate(randomShape, by: .half), on: .vertical),
                mirror(randomShape, on: .horizontal)
            )
        }
    }
    
    func testVerticalMirrorIsHorizontalMirroredHalfRotation() {
        
        for _ in 0 ..< 1000 {
            let randomShape = (0 ..< 6).reduce(Coordinates()) { set, _ in
                set.inserting(.random(in: 0 ..< 3))
            }
            
            XCTAssertEqual(
                
                mirror(rotate(randomShape, by: .half), on: .horizontal),
                mirror(randomShape, on: .vertical)
            )
        }
    }
    
    func testApplicationOfTransforms() {
        
        let transforms = TransformCollection()
            .mirrored(on: .horizontal)
            .rotated(amount: .full)
            .mirrored(on: .horizontal)
            .rotated(amount: .half)
            .mirrored(on: .vertical)
            .rotated(amount: .quarter)
            .rotated(amount: .quarter)
            .mirrored(on: .vertical)
        
        XCTAssertEqual(base.applying(transforms: transforms), base)
    }
    
    func testAvailableMoveCalculation() {
        
        let threePiece = Piece(config: .three, color: .blue)
        XCTAssertEqual(
            threePiece.coordinates.availableMoves,
            [
                Coordinate(x: -1, y: -1),
                Coordinate(x: -1, y: 1),
                Coordinate(x: 3, y: -1),
                Coordinate(x: 3, y: 1)
            ]
        )
        
        let stairs = Piece(config: .stairs, color: .blue)
        XCTAssertEqual(
            stairs.coordinates.availableMoves,
            [
                Coordinate(x: 0, y: -1),
                Coordinate(x: 3, y: -1),
                Coordinate(x: -1, y: 0),
                Coordinate(x: -1, y: 3),
                Coordinate(x: 1, y: 3),
                Coordinate(x: 2, y: 2),
                Coordinate(x: 3, y: 1)
            ]
        )
    }
    
    func testCorners() {
        
        let threePiece = Piece(config: .three, color: .blue)
        XCTAssertEqual(
            threePiece.coordinates.corners,
            [
                Coordinate(x: 0, y: 0),
                Coordinate(x: 2, y: 0)
            ]
        )
        
        let stairs = Piece(config: .stairs, color: .blue)
        XCTAssertEqual(
            stairs.coordinates.corners,
            stairs.coordinates
        )
    }
}
