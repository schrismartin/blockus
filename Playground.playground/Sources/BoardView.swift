import Foundation
import Blockus
import UIKit

public class BoardView: UIView {
    
    public static let defaultFrame = CGRect(x: 0, y: 0, width: 600, height: 600)
    public static let defaultMargin: CGFloat = 2
    
    public var board: Board {
        didSet { setNeedsDisplay() }
    }
    
    public init(board: Board, frame: CGRect = BoardView.defaultFrame) {
        self.board = board
        super.init(frame: frame)
    }
    
    override public func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        for (coordinate, tile) in board.indexedTiles() {
            
            let frame = self.rect(for: coordinate, boardSize: board.size)
            let color = tile.color.flatMap(UIColor.color) ?? .lightGray
            
            color.setFill()
            context?.fill(frame)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardView {
    
    private func cellSize(
        forBoardSize boardSize: Size,
        margin: CGFloat = BoardView.defaultMargin
        ) -> CGSize {
        
        let collectiveHorizontalMargin = CGFloat(boardSize.width + 1) * margin
        let collectiveVerticalMargin = CGFloat(boardSize.height + 1) * margin
        
        return CGSize(
            width: (bounds.width - collectiveHorizontalMargin) / CGFloat(boardSize.width),
            height: (bounds.height - collectiveVerticalMargin) / CGFloat(boardSize.height)
        )
    }
    
    private func rect(
        for coordinate: Coordinate,
        boardSize: Size,
        margin: CGFloat = BoardView.defaultMargin
        ) -> CGRect {
        
        let size = self.cellSize(forBoardSize: boardSize, margin: margin)
        
        let origin = CGPoint(
            x: margin + (size.width + margin) * CGFloat(coordinate.x),
            y: margin + (size.height + margin) * CGFloat(coordinate.y)
        )
        
        return CGRect(origin: origin, size: size)
    }
}
