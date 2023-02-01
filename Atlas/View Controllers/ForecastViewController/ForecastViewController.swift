//
//  ForecastViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

final class ForecastViewController: UIViewController {
    var titleF: String?

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(titleF)
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    private func setupView() {
        // Configure View
        view.backgroundColor = UIColor(named: "SUNNY")
    }
}
