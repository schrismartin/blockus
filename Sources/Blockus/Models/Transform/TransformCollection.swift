//
//  TransformCollection.swift
//  Blockus
//
//  Created by Chris Martin on 12/29/18.
//

import Foundation

public struct TransformCollection: Settable, Equatable {
    
    var transforms: [Transform]
    
    public init() {
        transforms = []
    }
    
    public func mirrored(on axis: Axis) -> TransformCollection {
        return adding(.mirrored(axis: axis))
    }
    
    public func rotated(amount: Rotation) -> TransformCollection {
        return adding(.rotated(amount: amount))
    }
    
    func adding(_ transform: Transform) -> TransformCollection {
        return self.setting(path: \TransformCollection.transforms) { transforms in
            transforms.append(transform)
        }.coalesced()
    }
    
    private func coalesced() -> TransformCollection {
        
        let coalescedTransforms = Substitution.allCases.reduce(self) { (transform, substitution) in
            transform.applying(substitution: substitution)
        }
        
        return coalescedTransforms == self
            ? coalescedTransforms
            : coalescedTransforms.coalesced()
    }
    
    private func applying(substitution: Substitution) -> TransformCollection {
        
        var transforms = self.transforms
        if let range = transforms.range(of: substitution.contents) {
            transforms.replaceSubrange(
                range,
                with: [substitution.replacement].compactMap { $0 }
            )
        }
        
        if substitution.isReversable {
            let newSubstitution = substitution
                .setting(path: \.contents, to: substitution.contents.reversed())
                .setting(path: \.isReversable, to: false)
            
            return setting(path: \.transforms, to: transforms)
                .applying(substitution: newSubstitution)
        }
        else {
            return setting(path: \.transforms, to: transforms)
        }
    }
    
    public static func + (lhs: TransformCollection, rhs: Transform) -> TransformCollection {
        return lhs.adding(rhs)
    }
    
    private struct Substitution: CaseIterable, Settable {
    
        var contents: [Transform]
        var replacement: Transform?
        var isReversable: Bool
        
        init(contents: [Transform], replacement: Transform?, isReversable: Bool = false) {
            self.contents = contents
            self.replacement = replacement
            self.isReversable = isReversable
        }
        
        static var allCases: [Substitution] = [
            .verticalFlip,
            .horizontalFlip,
            .identityVerticalFlip,
            .identityHorizontalFlip,
            .halfClockwiseRotation,
            .halfCounterClockwiseRotation,
            .clockwiseRotation,
            .counterClockwiseRotation,
            .canceledRotations,
            .halfRotation
        ]
        
        static let verticalFlip = Substitution(
            contents: [
                .mirrored(axis: .horizontal),
                .rotated(amount: .half)
            ],
            replacement: .mirrored(axis: .vertical),
            isReversable: true
        )
        
        static let horizontalFlip = Substitution(
            contents: [
                .mirrored(axis: .vertical),
                .rotated(amount: .half)
            ],
            replacement: .mirrored(axis: .horizontal),
            isReversable: true
        )
        
        static let identityVerticalFlip = Substitution(
            contents: [
                .mirrored(axis: .vertical),
                .mirrored(axis: .vertical)
            ],
            replacement: nil
        )
        
        static let identityHorizontalFlip = Substitution(
            contents: [
                .mirrored(axis: .horizontal),
                .mirrored(axis: .horizontal)
            ],
            replacement: nil
        )
        
        static let halfClockwiseRotation = Substitution(
            contents: [
                .rotated(amount: .quarter),
                .rotated(amount: .quarter)
            ],
            replacement: .rotated(amount: .half)
        )
        
        static let halfCounterClockwiseRotation = Substitution(
            contents: [
                .rotated(amount: .threeQuarters),
                .rotated(amount: .threeQuarters)
            ],
            replacement: .rotated(amount: .half)
        )
        
        static let clockwiseRotation = Substitution(
            contents: [
                .rotated(amount: .threeQuarters),
                .rotated(amount: .half)
            ],
            replacement: .rotated(amount: .quarter),
            isReversable: true
        )
        
        static let counterClockwiseRotation = Substitution(
            contents: [
                .rotated(amount: .quarter),
                .rotated(amount: .half)
            ],
            replacement: .rotated(amount: .threeQuarters),
            isReversable: true
        )
        
        static let canceledRotations = Substitution(
            contents: [
                .rotated(amount: .quarter),
                .rotated(amount: .threeQuarters)
            ],
            replacement: nil,
            isReversable: true
        )
        
        static let halfRotation = Substitution(
            contents: [
                .rotated(amount: .half),
                .rotated(amount: .half)
            ],
            replacement: nil
        )
    }
}
