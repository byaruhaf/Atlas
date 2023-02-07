//
//  FavoriteCitiesViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 04/02/2023.
//

import UIKit
import Combine

class FavoriteCitiesViewController: UIViewController {
    private var chosenCityCancellable: AnyCancellable?
    var favorites = UserDefaults.locations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityTapped))
        print(favorites)
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
                    // Update User Defaults
                    UserDefaults.addLocation(city)
                    
                    // Update Locations
                    self.favorites.append(city)
                }
            }
    }
}
