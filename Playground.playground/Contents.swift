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

boardView.auxilaryCoordinates = boardView.board.availableMoves(for: .blue)
