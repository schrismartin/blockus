//
//  PieceEditViewController.swift
//  BlockusApp
//
//  Created by Chris Martin on 1/19/19.
//  Copyright © 2019 Chris Martin. All rights reserved.
//

import UIKit
import Blockus

class PieceEditViewController: UIViewController {
    
    // MARK: - UI Properties
    
    @IBOutlet private weak var pieceView: TileCollectionView!
    
    @IBOutlet private weak var rotateClockwiseButton: UIView!
    @IBOutlet private weak var rotateCounterClockwiseButton: UIButton!
    
    @IBOutlet private weak var flipHorizontalButton: UIButton!
    @IBOutlet private weak var flipVerticalButton: UIButton!
    
    // MARK: - Dependencies
    
    var piece: Piece? {
        didSet { redrawPiece() }
    }
    
    var transforms = TransformCollection() {
        didSet { redrawPiece(); print(transforms) }
    }
    
    private var placedPiece: PlacedPiece? {
        return piece.flatMap { piece in
            PlacedPiece(piece: piece, origin: .zero, transforms: self.transforms)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    
    func redrawPiece() {
        
        placedPiece.flatMap(pieceView.drawTiles)
    }
    
    @IBAction func rotateClockwiseButtonPressed(_ sender: UIButton) {
        
        transforms = transforms.rotated(amount: .quarter)
    }
    
    @IBAction func rotateCounterClockwiseButtonPressed(_ sender: UIButton) {
        
        transforms = transforms.rotated(amount: .threeQuarters)
    }
    
    @IBAction func flipHorizontalButtonPressed(_ sender: UIButton) {
        
        transforms = transforms.mirrored(on: .horizontal)
    }
    
    @IBAction func flipVerticalButtonPressed(_ sender: UIButton) {
        
        transforms = transforms.mirrored(on: .vertical)
    }
}
