//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Blockus

PlaygroundPage.current.needsIndefiniteExecution = true

let board = Board(size: Size(width: 20, height: 20))

let boardView = BoardView(board: board)
PlaygroundPage.current.liveView = boardView

boardView.board = try board.place(
    piece: Piece(config: .bigL, color: .red),
    at: Coordinate(x: 7, y: 8),
    transforms: TransformCollection()
)

boardView.board = try boardView.board.place(
    piece: Piece(config: .bigL, color: .green),
    at: Coordinate(x: 6, y: 9),
    transforms: TransformCollection()
)

boardView.board = try boardView.board.place(
    piece: Piece(config: .bigL, color: .blue),
    at: Coordinate(x: 8, y: 9),
    transforms: TransformCollection()
        .rotated(amount: .half)
)

boardView.board = try boardView.board.place(
    piece: Piece(config: .bigL, color: .yellow),
    at: Coordinate(x: 9, y: 8),
    transforms: TransformCollection()
        .rotated(amount: .half)
)
