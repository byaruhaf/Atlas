//
//  Location.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 05/02/2023.
//

import Foundation
import CoreLocation

struct Location {
    private enum Keys {
        
        static let name = "name"
        static let locality = "locality"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    // MARK: - Properties
    let name: String
    let locality: String
    let latitude: Double
    let longitude: Double
    
    // MARK: -
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    // MARK: -
    
    var asDictionary: [String: Any] {
        [ Keys.name: name, Keys.locality: locality, Keys.latitude: latitude, Keys.longitude: longitude ]
    }
}

extension Location {
    // MARK: - Initialization
    init(location: CLLocationCoordinate2D) {
        name = ""
        locality = ""
        latitude = location.latitude
        longitude = location.longitude
    }
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary[Keys.name] as? String else { return nil }
        guard let locality = dictionary[Keys.locality] as? String else { return nil }
        guard let latitude = dictionary[Keys.latitude] as? Double else { return nil }
        guard let longitude = dictionary[Keys.longitude] as? Double else { return nil }
        
        self.name = name
        self.locality = locality
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Location: Equatable, Hashable, Codable {
}
