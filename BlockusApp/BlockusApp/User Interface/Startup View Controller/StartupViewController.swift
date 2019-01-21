//
//  StartupViewController.swift
//  BlockusApp
//
//  Created by Chris Martin on 1/19/19.
//  Copyright © 2019 Chris Martin. All rights reserved.
//

import UIKit
import Blockus

class StartupViewController: UIViewController {

    @IBOutlet weak var playGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure(playGameButton: playGameButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure(navigationItem: navigationItem)
        
        if let navigationBar = navigationController?.navigationBar {
            configure(navigationBar: navigationBar)
        }
    }
    
    @IBAction func playGameButtonPressed(_ sender: Any) {
        
        let game = Game()
        let gameViewController = GameViewController(game: game)
        let navigationController = UINavigationController(rootViewController: gameViewController)
        show(navigationController, sender: nil)
    }
}

extension StartupViewController {
    
    func configure(playGameButton: UIButton) {
        
        playGameButton.layer.cornerRadius = 8
        playGameButton.clipsToBounds = true
    }
    
    func configure(navigationBar: UINavigationBar) {
        
        navigationBar.prefersLargeTitles = true
    }
    
    func configure(navigationItem: UINavigationItem) {
        
        navigationItem.title = "Main Menu"
    }
}
