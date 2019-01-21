//
//  GameViewController.swift
//  BlockusApp
//
//  Created by Chris Martin on 1/19/19.
//  Copyright © 2019 Chris Martin. All rights reserved.
//

import UIKit
import Blockus

class GameViewController: UIViewController {
    
    // MARK: - UI Components
    
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var pieceEditContainerView: TileCollectionView!
    
    let pieceEditViewController = PieceEditViewController()
    
    // MARK: - Dependencies
    
    var game: Game
    
    // MARK: - Initializers
    
    init(game: Game) {
        
        self.game = game
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure(boardView: boardView)
        configure(pieceEditController: pieceEditViewController, in: pieceEditContainerView)
        
        let color = game.currentPlayerTurn
        if let config = game.remainingPieces(for: color).first {
            let piece = Piece(config: config, color: color)
            pieceEditViewController.piece = piece
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure(navigationItem: navigationItem)
        
        if let navigationBar = navigationController?.navigationBar {
            configure(navigationBar: navigationBar)
        }
    }
    
    // MARK: - Actions
    
    @objc func quitGameButtonPressed() {
        
        dismiss(animated: true)
    }
}

// MARK: - Configuration
extension GameViewController {
    
    func configure(boardView: BoardView) {
        
        game.view = boardView
    }
    
    func configure(navigationBar: UINavigationBar) {
        
        navigationBar.prefersLargeTitles = false
    }
    
    func configure(pieceEditController: PieceEditViewController, in container: UIView) {
        
        guard
            pieceEditController.parent == nil,
            pieceEditController.view.superview == nil
        else { return }
        
        addChild(pieceEditController)
        
        let subview: UIView = pieceEditController.view
        container.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: subview.topAnchor),
            container.leftAnchor.constraint(equalTo: subview.leftAnchor),
            container.rightAnchor.constraint(equalTo: subview.rightAnchor),
            container.bottomAnchor.constraint(equalTo: subview.bottomAnchor)
        ])
        
        pieceEditController.didMove(toParent: self)
        
        view.setNeedsLayout()
    }
    
    func configure(navigationItem: UINavigationItem) {
        
        navigationItem.title = "Game"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Quit Game",
            style: .done,
            target: self,
            action: #selector(quitGameButtonPressed)
        )
    }
}
