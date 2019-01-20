//
//  ViewController.swift
//  BlockusApp
//
//  Created by Chris Martin on 1/19/19.
//  Copyright © 2019 Chris Martin. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {
    
    var navController: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        start()
    }
    
    func start() {
        
        let startupController = StartupViewController()
        let navigationController = UINavigationController(rootViewController: startupController)
        
        present(navigationController, animated: false)
        navController = navigationController
    }
}
