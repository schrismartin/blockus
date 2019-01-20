//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Blockus

PlaygroundPage.current.needsIndefiniteExecution = true

let board = Board(size: Size(width: 20, height: 20))
let boardView = BoardView(board: board)

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
