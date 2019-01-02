//
//  Game.swift
//  Blockus
//
//  Created by Chris Martin on 1/1/19.
//

import Foundation

public protocol GameBoardView: class {
    
    var board: Board { get set }
    
    func refresh()
}

public struct Game: Settable {
    
    var board: Board {
        didSet { view.flatMap(setUp) }
    }
    
    public var view: GameBoardView? {
        didSet { view.flatMap(setUp) }
    }
    
    public init(board: Board) {
        
        self.board = board
    }
    
    func setUp(view: GameBoardView) {
        
        view.board = board
        view.refresh()
    }
    
    static let turnOrder: [Color] = [
        .blue, .yellow, .green, .red
    ]
    
    public func remainingPieces(for color: Color) -> Set<PieceConfiguration> {
        
        let allPieces = PieceConfiguration.allCases.toSet()
        
        return board.pieces(of: color)
            .setMap { $0.piece.config }
            .reduce(allPieces) { pieces, piece in pieces.removing(piece) }
    }
    
    public var currentPlayerTurn: Color {
        
        let currentPlayer = Game.turnOrder.max { first, second in
            remainingPieces(for: first).count < remainingPieces(for: second).count
        }
        
        return currentPlayer!
    }
    
    public func play(as color: Color) throws -> Turn<Ready> {
        
        let currentTurn = currentPlayerTurn
        guard color == currentTurn else {
            throw Error.invalidTurn(attempted: color, current: currentTurn)
        }
        
        return Turn(
            color: color,
            board: board,
            availablePieces: remainingPieces(for: color)
        )
    }
    
    public func commit(turn: Turn<Finished>) -> Game {
        
        return setting(path: \.board, to: turn.board)
    }
}

extension Game {
    
    enum Error: Swift.Error {
        case invalidTurn(attempted: Color, current: Color)
        case unplayablePiece(PieceConfiguration)
    }
}

public protocol TurnState { }

public enum Ready: TurnState { }
public enum Finished: TurnState { }

public struct Turn<State: TurnState>: Settable {
    
    var color: Color
    var board: Board
    var availablePieces: Set<PieceConfiguration>
    
    init(from turn: Turn<Ready>) {
        color = turn.color
        board = turn.board
        availablePieces = turn.availablePieces
    }
}

extension Turn where State == Ready {
    
    init(color: Color, board: Board, availablePieces: Set<PieceConfiguration>) {
        self.color = color
        self.board = board
        self.availablePieces = availablePieces
    }
    
    public func placing(piece: PieceConfiguration, at origin: Coordinate, transforms: TransformCollection = .init()) throws -> Turn<Finished> {
        
        guard availablePieces.contains(piece) else {
            throw Game.Error.unplayablePiece(piece)
        }
        
        return try Turn<Finished>(from: self).setting(path: \Turn<Finished>.board) { board in
            
            try board.place(
                piece: Piece(config: piece, color: color),
                at: origin,
                transforms: transforms
            )
        }
    }
}
