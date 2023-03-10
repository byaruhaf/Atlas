//
//  TabBarController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit
import os.log

class TabBarController: UITabBarController {
    // MARK: - Properties
    
    private var viewModel: CurrentLocationViewModel
    
    // MARK: - Initialization
    
    init?(coder: NSCoder, viewModel: CurrentLocationViewModel) {
        self.viewModel = viewModel
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        Logger.network.error("Use `init(coder:viewModel:)` to instantiate a `ViewController` instance")
        fatalError("Use `init(coder:viewModel:)` to instantiate a `ViewController` instance.")
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()
    }
    
    // MARK: - Helper Methods

    private func setupChildViewControllers() {
        guard let viewControllers else { return }
        
        for viewController in viewControllers {
            var childViewController: UIViewController?
            
            if let navigationController = viewController as? UINavigationController {
                childViewController = navigationController.viewControllers.first
            } else {
                childViewController = viewController
            }
            
            // Dependency Injection
            switch childViewController {
            case let viewController as CurrentLocationViewController:
                // Initialize View Model
                viewController.viewModel = self.viewModel
            default:
                break
            }
        }
    }
}
