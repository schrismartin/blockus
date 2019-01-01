//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Blockus

PlaygroundPage.current.needsIndefiniteExecution = true

let board = Board(size: Size(width: 20, height: 20))

let boardView = BoardView(board: board)
PlaygroundPage.current.liveView = boardView

// MARK: - Design 1

boardView.board = try board.place(
    piece: Piece(config: .bigL, color: .red),
    at: Coordinate(x: 7, y: 8),
    transforms: nil
)

boardView.board = try boardView.board.place(
    piece: Piece(config: .bigL, color: .green),
    at: Coordinate(x: 6, y: 9),
    transforms: nil
)

boardView.board = try boardView.board.place(
    piece: Piece(config: .bigL, color: .blue),
    at: Coordinate(x: 8, y: 9),
    transforms: .rotated(amount: .half)
)

boardView.board = try boardView.board.place(
    piece: Piece(config: .bigL, color: .yellow),
    at: Coordinate(x: 9, y: 8),
    transforms: .rotated(amount: .half)
)

// MARK: - Design 2

boardView.board = try boardView.board.place(
    piece: Piece(config: .bigL, color: .blue),
    at: Coordinate(x: 7, y: 2),
    transforms: nil
)

boardView.board = try boardView.board.place(
    piece: Piece(config: .bigL, color: .green),
    at: Coordinate(x: 8, y: 1),
    transforms: .rotated(amount: .half)
)

boardView.board = try boardView.board.place(
    piece: Piece(config: .corner, color: .red),
    at: Coordinate(x: 8, y: 2),
    transforms: .rotated(amount: .threeQuarters)
)

boardView.board = try boardView.board.place(
    piece: Piece(config: .one, color: .yellow),
    at: Coordinate(x: 9, y: 3),
    transforms: .rotated(amount: .threeQuarters)
)

boardView.auxilaryCoordinates = boardView.board.availableMoves
