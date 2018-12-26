//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Blockus

var board = Board(size: Size(width: 20, height: 20))
let boardView = BoardView(board: board)

PlaygroundPage.current.liveView = boardView

let piece = Piece(
    string: """
            XXX
            XX
             X
            """,
    color: .red
)

let bluePiece = Piece(
    string: """
             X
             X
            XX
            """,
    color: .blue
)

boardView.board = try board
    .place(piece: piece, at: Coordinate(x: 5, y: 5))
    .place(piece: bluePiece, at: Coordinate(x: 0, y: 0))
