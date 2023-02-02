//
//  TabBarController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

class TabBarController: UITabBarController {
    // MARK: - Properties
    
    private var viewModel: CurrentLocationViewModel
    
    // MARK: - Initialization
    
    init?(coder: NSCoder, viewModel: CurrentLocationViewModel) {
        self.viewModel = viewModel
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:viewModel:)` to instantiate a `ViewController` instance.")
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()
    }
    
    // MARK: - Helper Methods

    private func setupChildViewControllers() {
//        guard let viewControllers = viewControllers else {
//            return
//        }
//
//        // Dependency Injection
//        for viewController in viewControllers {
//            switch viewController {
//            case let viewController as CurrentLocationViewController:
//                viewController.viewModel = self.viewModel
//            default:
//                break
//            }
//        }
        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            var childViewController: UIViewController?
            
            if let navigationController = viewController as? UINavigationController {
                childViewController = navigationController.viewControllers.first
            } else {
                childViewController = viewController
            }
            
            switch childViewController {
            case let viewController as CurrentLocationViewController:
                // Initialize View Model
                viewController.viewModel = self.viewModel
            case let viewController as FavoritesViewController:
                // Initialize View Model
                let viewModel = FavoritesViewModel()
                
                // Configure View Controller
                viewController.viewModel = viewModel
            default:
                break
            }
        }
    }
}
