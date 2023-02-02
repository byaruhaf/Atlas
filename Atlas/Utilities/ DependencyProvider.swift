//
//   DependencyProvider.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import Foundation
import UIKit

enum DependencyProvider {
//    static var service: Servicing {
//        return Service()
//    }
//
//    static var viewModel: ViewModel {
//        return ViewModel(service: self.service)
//    }
//
//    static var viewController: ViewController {
//        let vc = UIStoryboard(name: "Main",
//                              bundle: nil).instantiateInitialViewController() as! ViewController
//        vc.viewModel = viewModel
//        return vc
//    }
    
    static var viewModel: CurrentLocationViewModel {
        CurrentLocationViewModel()
    }
    
    static var rootViewController: TabBarController {
        let rootVC = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController { coder in
            TabBarController(coder: coder, viewModel: CurrentLocationViewModel())
        }
        return rootVC!
    }
}
