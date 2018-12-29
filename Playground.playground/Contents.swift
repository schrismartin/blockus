//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Blockus

PlaygroundPage.current.needsIndefiniteExecution = true

let board = try Board(size: Size(width: 20, height: 20))
    .place(
        piece: Piece(config: .stairs, color: .blue),
        at: Coordinate(x: 3, y: 3)
    )

//func drawBoard(forPieceAtIndex index: Int, using board: Board) throws {
//
//    let boardView = BoardView(board: board)
//    PlaygroundPage.current.liveView = boardView
//
//    let piece = Piece.random(
//        of: Size(width: 2, height: 3),
//        numberOfPieces: 5,
//        color: .red
//    )
//
//    let place = Coordinate(x: 5, y: 5)
//
//    boardView.board = try board
//        .place(piece: piece, at: place)
//
//    boardView.auxilaryCoordinates = Set(piece.calculateAvailableMoves()
//        .map { coord in coord.offset(by: place) })
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
//        try! drawBoard(forPieceAtIndex: index + 1, using: board)
//    }
//}
//
//try drawBoard(forPieceAtIndex: 0, using: board)


let boardView = BoardView(board: board)
PlaygroundPage.current.liveView = boardView

boardView.auxilaryCoordinates = Piece(config: .stairs, color: .blue)
    .calculateAvailableMoves()
    .setMap { coord in coord.offset(by: Coordinate(x: 3, y: 3)) }
