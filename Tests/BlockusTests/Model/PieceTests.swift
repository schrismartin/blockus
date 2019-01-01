//
//  PieceTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 12/29/18.
//

import XCTest
@testable import Blockus

class PieceTests: XCTestCase {
    
    static let allTests = [
        ("testInitUsingConfig", testInitUsingConfig),
        ("testInitUsingCoordinates", testInitUsingCoordinates),
        ("testRandomPiece", testRandomPiece),
    ]

    func testInitUsingConfig() {
        
        let config = PieceConfiguration(string: "XXX")
        let piece = Piece(config: config, color: .blue)
        XCTAssertEqual(piece.coordinates, config.coordinates)
        XCTAssertEqual(piece.numberOfPieces, 3)
        XCTAssertEqual(piece.size, Size(width: 3, height: 1))
        XCTAssertEqual(piece.color, .blue)
    }
    
    func testInitUsingCoordinates() {
        
        let coordinates: Coordinates = [
            Coordinate(x: 0, y: 0),
            Coordinate(x: 1, y: 0),
            Coordinate(x: 0, y: 1)
        ]
        
        let piece = Piece(coordinates: coordinates, color: .green)
        
        XCTAssertEqual(piece.coordinates, coordinates)
        XCTAssertEqual(piece.numberOfPieces, 3)
        XCTAssertEqual(piece.size, Size(width: 2, height: 2))
        XCTAssertEqual(piece.color, .green)
    }
    
    func testRandomPiece() {
        
        for size in 0 ..< 100 {
            let piece = Piece.random(
                of: Size(width: size, height: size),
                numberOfPieces: size,
                color: .blue
            )
            
            XCTAssertLessThanOrEqual(piece.size.area, Size(width: size + 1, height: size + 1).area)
            XCTAssertLessThanOrEqual(piece.numberOfPieces, size)
            XCTAssertEqual(piece.color, .blue)
        }
    }
}
