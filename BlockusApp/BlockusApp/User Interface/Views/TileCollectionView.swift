//
//  TileView.swift
//  BlockusApp
//
//  Created by Chris Martin on 1/19/19.
//  Copyright © 2019 Chris Martin. All rights reserved.
//

import Foundation
import Blockus
import UIKit

public class TileCollectionView: UIView, TileCollectionDrawable {
    
    var tileCollection: TileCollection? {
        didSet { refresh() }
    }
    
    public func refresh() {
        
        setNeedsDisplay()
    }
    
    public func drawTiles(in tileCollection: TileCollection) {
        
        self.tileCollection = tileCollection
    }
    
    override public func draw(_ rect: CGRect) {
        
        guard let tileCollection = tileCollection else { return }
        
        do {
            try drawViewTiles(in: tileCollection)
        }
        catch {
            print(error)
        }
    }
    
    private func drawViewTiles(in tileProvider: TileCollection) throws {
        
        let context = UIGraphicsGetCurrentContext()
        
        for coordinate in tileProvider.coordinates {
            
            let frame = self.rect(for: coordinate, canvasSize: tileProvider.size)
            let color = tileProvider.tile(at: coordinate).flatMap(UIColor.color) ?? .clear
            
            color.setFill()
            context?.fill(frame)
        }
    }
    
    func cellSize(
        forBoardSize boardSize: Size,
        margin: CGFloat = BoardView.defaultMargin
        ) -> CGSize {
        
        let viewAspectRatio = bounds.height / bounds.width
        
        let collectiveHorizontalMargin = CGFloat(boardSize.width + 1) * margin
        let collectiveVerticalMargin = CGFloat(boardSize.height + 1) * margin
        
        if viewAspectRatio > CGFloat(boardSize.aspectRatio) {
            
            let adjustedHeight = bounds.width * CGFloat(boardSize.aspectRatio)
            return CGSize(
                width: (bounds.width - collectiveHorizontalMargin) / CGFloat(boardSize.width),
                height: (adjustedHeight - collectiveVerticalMargin) / CGFloat(boardSize.height)
            )
        }
        else {
            
            let adjustedWidth = bounds.width / CGFloat(boardSize.aspectRatio)
            return CGSize(
                width: (adjustedWidth - collectiveHorizontalMargin) / CGFloat(boardSize.width),
                height: (bounds.height - collectiveVerticalMargin) / CGFloat(boardSize.height)
            )
        }
    }
    
    func rect(
        for coordinate: Coordinate,
        canvasSize: Size,
        margin: CGFloat = BoardView.defaultMargin
    ) -> CGRect {
        
        let size = self.cellSize(forBoardSize: canvasSize, margin: margin)
        
        let origin = CGPoint(
            x: margin + (size.width + margin) * CGFloat(coordinate.x),
            y: margin + (size.height + margin) * CGFloat(coordinate.y)
        )
        
        return CGRect(origin: origin, size: size)
    }
}

extension CGSize {
    
    var isPortrait: Bool {
        return height > width
    }
    
    var isLandscape: Bool {
        return width > height
    }
}
