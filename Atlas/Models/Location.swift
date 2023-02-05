//
//  Location.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 05/02/2023.
//

import Foundation
import CoreLocation

struct Location {
    
    // MARK: - Properties
    
    let latitude: Double
    let longitude: Double
}

extension Location {
    
    // MARK: - Initialization
    
    init(location: CLLocationCoordinate2D) {
        latitude = location.latitude
        longitude = location.longitude
    }
}
