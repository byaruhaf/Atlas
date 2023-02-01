//
//  DayViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

final class DayViewController: UIViewController {
    
    @IBOutlet var imageDayBG: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    private func setupView() {
        // Configure View
        view.backgroundColor = UIColor(named: "SUNNY")
        imageDayBG.image = UIImage(named: "forest_sunny")
    }
}
