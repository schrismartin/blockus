//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
@testable import Blockus
//@testable import BlockusApp

PlaygroundPage.current.needsIndefiniteExecution = true

public extension Collection where Element: Equatable {
    
    public func range(of subCollection: Self) -> Range<Index>? {
        
        guard subCollection.count <= count else  { return nil }
        
        var startIndex: Self.Index?
        
        var subIndex = subCollection.startIndex
        for index in indices {
            let element = self[index]
            guard subCollection.indices.contains(subIndex) else { break }
            
            if subCollection[subIndex] != element {
                subIndex = subCollection.startIndex
                startIndex = nil
            }
            
            if subCollection[subIndex] == element {
                if subIndex == subCollection.startIndex { startIndex = index }
                subIndex = subCollection.index(subIndex, offsetBy: 1)
                if subIndex == subCollection.endIndex { break }
            }
        }
        
        guard let firstIndex = startIndex else { return nil }
        return Range(uncheckedBounds: (firstIndex, index(firstIndex, offsetBy: subCollection.count)))
    }
}

// -------------------------------

let collection = TransformCollection()
    .mirrored(on: .horizontal)
    .mirrored(on: .horizontal)

collection.transforms.range(osf: [.mirrored(axis: .horizontal), .rotated(amount: .half)])

collection.transforms.range(osf: [.mirrored(axis: .horizontal), .mirrored(axis: .horizontal)])

// -------------------------------

let board = Board(size: Size(width: 20, height: 20))
let boardView = BoardView()
boardView.drawTiles(in: board)

var game = Game(board: board)
    .setting(path: \Game.view, to: boardView)

// -------------------------------

PlaygroundPage.current.liveView = boardView

print(game.currentPlayerTurn)

game = try game.commit(turn:
    game.play(as: .blue).placing(piece: .bigL, at: .zero)
)

game = try game.playingTurn { turn in
    try turn.placing(
        piece: .bigL,
        at: Coordinate(x: 17, y: 0),
        transforms: TransformCollection()
            .mirrored(on: .horizontal)
    )
}

game = try game.playingTurn { turn in
    try turn.placing(
        piece: .bigL,
        at: Coordinate(x: 17, y: 17),
        transforms: TransformCollection()
            .mirrored(on: .horizontal)
            .mirrored(on: .vertical)
    )
}

game = try game.playingTurn { turn in
    try turn.placing(
        piece: .bigL,
        at: Coordinate(x: 0, y: 17),
        transforms: TransformCollection()
            .mirrored(on: .horizontal)
    )
}

boardView.auxilaryCoordinates = boardView.board.availableMoves
