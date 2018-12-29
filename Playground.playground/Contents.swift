//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Blockus

PlaygroundPage.current.needsIndefiniteExecution = true

let board = Board(size: Size(width: 20, height: 20))

func drawBoard(forPieceAtIndex index: Int, using board: Board) throws {

    let boardView = BoardView(board: board)
    PlaygroundPage.current.liveView = boardView

    let wrappedIndex = index % PieceConfiguration.allPieces.count
    let piece = Piece(config: PieceConfiguration.allPieces[wrappedIndex], color: .red)

    boardView.board = try board
        .place(piece: piece, at: board.size.center)

    boardView.auxilaryCoordinates = Set(piece.calculateAvailableMoves()
        .map { coord in coord.offset(by: board.size.center) })

    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        try! drawBoard(forPieceAtIndex: index + 1, using: board)
    }
}

try drawBoard(forPieceAtIndex: 0, using: board)
