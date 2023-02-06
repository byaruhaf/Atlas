//
//  FavoritesCollectionViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 04/02/2023.
//

import UIKit
import Combine

class FavoritesCollectionViewController: UIViewController {
    private var chosenCityCancellable: AnyCancellable?
//    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityTapped))
    }
    
    @objc private func addCityTapped() {
        let addCityVC = AddCityViewController()
        let addCityNav = UINavigationController(rootViewController: addCityVC)
        present(addCityNav, animated: true, completion: nil)
        
        chosenCityCancellable = addCityVC.$chosenCity
            .dropFirst()
            .sink { city in
                addCityNav.dismiss(animated: true, completion: nil)
                
                if let city = city {
                    print("Save Chosen city: \(city)")
                }
            }
    }
}
