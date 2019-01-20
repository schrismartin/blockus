import Foundation
import Blockus
import UIKit

public class BoardView: TileCollectionView {
    
    public static let defaultMargin: CGFloat = 2
    
    public var auxilaryTileColor = UIColor.yellow.withAlphaComponent(0.5) {
        didSet { refresh() }
    }

    public var auxilaryCoordinates: Coordinates = [] {
        didSet { refresh() }
    }

    override public func draw(_ rect: CGRect) {

        backgroundColor = .gray
        
        guard let tileCollection = tileCollection else { return }

        drawGrid(size: tileCollection.size)
        super.draw(rect)
        drawGuideTiles(in: auxilaryCoordinates)
    }
    
    func drawGrid(size: Size) {
        
        guard let tileCollection = tileCollection else { return }
        
        let context = UIGraphicsGetCurrentContext()
        
        let coordinates = Set((0 ..< size.width)
            .flatMap { x in (0 ..< size.height).setMap { y in Coordinate(x: x, y: y) } })
        
        for coordinate in coordinates {
            let frame = rect(for: coordinate, canvasSize: tileCollection.size)
            UIColor.lightGray.setFill()
            context?.fill(frame)
        }
    }

    func drawGuideTiles(in auxilaryCoordinates: Coordinates) {
        
        guard let tileCollection = tileCollection else { return }

        let context = UIGraphicsGetCurrentContext()

        for coordinate in auxilaryCoordinates {

            let frame = self.rect(for: coordinate, canvasSize: tileCollection.size)
            auxilaryTileColor.setFill()
            context?.fill(frame)
        }
    }
}
