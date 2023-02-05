//
//   DependencyProvider.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import Foundation
import UIKit

enum DependencyProvider {
    static var locationSservice: LocationServicing {
        LocationSservice()
    }
    
    static var networkSservice: NetworkServicing {
        NetworkSservice()
    }
    
    static var viewModel: CurrentLocationViewModel {
        CurrentLocationViewModel(locationService: self.locationSservice, networkService: self.networkSservice)
    }
    
    static var rootViewController: TabBarController {
        let rootVC = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController { coder in
            TabBarController(coder: coder, viewModel: self.viewModel)
        }
        return rootVC!
    }
}
