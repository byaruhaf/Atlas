//
//  FavoritesNavigationViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 07/02/2023.
//

import UIKit

class FavoritesNavigationViewController: UINavigationController {
    
    private static let identifier = "FavoritesNavigationViewController"

    static func newInstance() -> FavoritesNavigationViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as! FavoritesNavigationViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
