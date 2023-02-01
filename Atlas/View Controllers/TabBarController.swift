//
//  TabBarController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup Child View Controllers
        setupChildViewControllers()
    }
    
    // MARK: - Helper Methods

    private func setupChildViewControllers() {
        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            switch viewController {
            case let viewController as CurrentLocationViewController:
                // Initialize View Model
                let viewModel = CurrentLocationViewModel()
                // Configure View Controller
                viewController.viewModel = viewModel
            default:
                break
            }
        }
    }
}
