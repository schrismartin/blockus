//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Blockus

var board = Board(size: Size(width: 20, height: 20))
let boardView = BoardView(board: board)

PlaygroundPage.current.liveView = boardView

let piece = Piece(config: .longL, color: .red)
let rotatedPiece = Piece(config: .longL, color: .blue)
    .rotated(by: .half, direction: .clockwise)
.rotated(by: .half, direction: .clockwise)

boardView.board = try board
    .place(piece: piece, at: Coordinate(x: 5, y: 5))
    .place(piece: rotatedPiece, at: Coordinate(x: 10, y: 5))
    .place(piece: rotatedPiece, at: Coordinate(x: 5, y: 10))
