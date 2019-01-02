//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Blockus

PlaygroundPage.current.needsIndefiniteExecution = true

do {

    let board = Board(size: Size(width: 20, height: 20))

    let boardView = BoardView(board: board)
    PlaygroundPage.current.liveView = boardView

    boardView.auxilaryTileColor = .black

    boardView.board = try boardView.board.place(
        piece: Piece(config: .longL, color: .blue),
        at: Coordinate(x: 0, y: 0)
    )
    
    boardView.board = try boardView.board.place(
        piece: Piece(config: .bigL, color: .blue),
        at: Coordinate(x: 2, y: 2),
        transforms: TransformCollection()
            .rotated(amount: .threeQuarters)
    )
    
    boardView.board = try boardView.board.place(
        piece: Piece(config: .corner, color: .blue),
        at: Coordinate(x: 4, y: 0),
        transforms: TransformCollection()
    )
    
    boardView.auxilaryCoordinates = boardView.board.availableMoves(for: .blue)
    
} catch {
    print(error)
}
