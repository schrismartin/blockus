//
//  TransformCollectionTests.swift
//  BlockusTests
//
//  Created by Chris Martin on 1/21/19.
//

import XCTest
@testable import Blockus

class TransformCollectionTests: XCTestCase {

    func testIdentityCoalesce() {
        
        let identityHorizontalCollection = TransformCollection()
            .mirrored(on: .horizontal)
            .mirrored(on: .horizontal)
        
       XCTAssertEqual(identityHorizontalCollection, TransformCollection())
        
        let identityVerticalCollection = TransformCollection()
            .mirrored(on: .vertical)
            .mirrored(on: .vertical)
        
        XCTAssertEqual(identityVerticalCollection, TransformCollection())
    }
    
    func testHalfMirrored() {
        
        // Horizontal to Vertical
        
        let horizontalFlippedHalfRotation = TransformCollection()
            .mirrored(on: .horizontal)
            .rotated(amount: .half)
        
        XCTAssertEqual(
            horizontalFlippedHalfRotation,
            TransformCollection()
                .mirrored(on: .vertical)
        )
        
        let halfRotationHorizontalFlip = TransformCollection()
            .rotated(amount: .half)
            .mirrored(on: .horizontal)
        
        XCTAssertEqual(
            halfRotationHorizontalFlip,
            TransformCollection()
                .mirrored(on: .vertical)
        )
        
        // Vertical to Horizontal
        
        let verticalFlippedHalfRotation = TransformCollection()
            .mirrored(on: .vertical)
            .rotated(amount: .half)
        
        XCTAssertEqual(
            verticalFlippedHalfRotation,
            TransformCollection()
                .mirrored(on: .horizontal)
        )
        
        let halfRotationVerticalFlip = TransformCollection()
            .rotated(amount: .half)
            .mirrored(on: .vertical)
        
        XCTAssertEqual(
            halfRotationVerticalFlip,
            TransformCollection()
                .mirrored(on: .horizontal)
        )
    }
    
    func testQuarterToHalf() {
        
        let twoQuarterRotations = TransformCollection()
            .rotated(amount: .quarter)
            .rotated(amount: .quarter)
        
        XCTAssertEqual(
            twoQuarterRotations,
            TransformCollection()
                .rotated(amount: .half)
        )
        
        let twoThreeQuarterRotations = TransformCollection()
            .rotated(amount: .threeQuarters)
            .rotated(amount: .threeQuarters)
        
        XCTAssertEqual(
            twoThreeQuarterRotations,
            TransformCollection()
                .rotated(amount: .half)
        )
    }
    
    func testHalfToWhole() {
        
        let twoHalfRotations = TransformCollection()
            .rotated(amount: .half)
            .rotated(amount: .half)
        
        XCTAssertEqual(
            twoHalfRotations,
            TransformCollection()
        )
    }
    
    func testCompoundRotations() {
        
        XCTAssertEqual(
            TransformCollection()
                .rotated(amount: .quarter)
                .rotated(amount: .threeQuarters)
                .rotated(amount: .threeQuarters)
                .rotated(amount: .quarter)
                ,
            TransformCollection()
        )
        
        XCTAssertEqual(
            TransformCollection()
                .rotated(amount: .threeQuarters)
                .rotated(amount: .threeQuarters)
                .rotated(amount: .threeQuarters)
                .rotated(amount: .quarter)
                ,
            TransformCollection()
                .rotated(amount: .half)
        )
        
        XCTAssertEqual(
            TransformCollection()
                .rotated(amount: .half)
                .rotated(amount: .threeQuarters)
                .rotated(amount: .threeQuarters)
                .rotated(amount: .quarter)
                ,
            TransformCollection()
                .rotated(amount: .quarter)
        )
        
        XCTAssertEqual(
            TransformCollection()
                .mirrored(on: .horizontal)
                .rotated(amount: .threeQuarters)
                .rotated(amount: .threeQuarters)
                .rotated(amount: .half)
                ,
            TransformCollection()
                .mirrored(on: .horizontal)
        )
    }
}
