//
//  UserDefaults+Extension.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 05/02/2023.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Types

    private enum Keys {
        static let didDataRefresh = "didDataRefresh"
        static let locations = "locations"
    }
    
    class func setDidDataRefresh(_ didSeedPersistentStore: Date) {
        UserDefaults.standard.set(didSeedPersistentStore, forKey: Keys.didDataRefresh)
    }
    
    class var getDidDataRefresh: Date? {
         UserDefaults.standard.object(forKey: Keys.didDataRefresh) as? Date
    }
}

extension UserDefaults {
    
    // MARK: - Locations
    
    class var locations: [Location] {
        get {
            guard let dictionaries = UserDefaults.standard.array(forKey: Keys.locations) as? [ [String: Any] ] else {
                return []
            }
            
            return dictionaries.compactMap { Location(dictionary: $0) }
        }
        set {
            // Transform Locations
            let dictionaries: [ [String: Any] ] = newValue.map { $0.asDictionary }
            
            // Save Locations
            UserDefaults.standard.set(dictionaries, forKey: Keys.locations)
        }
    }
    
    class func addLocation(_ location: Location) {
        // Load Locations
        var locations = self.locations
        
        // Add Location
        locations.append(location)
        
        // Save Locations
        self.locations = locations
    }
    
    class func removeLocation(_ location: Location) {
        // Load Locations
        var locations = self.locations
        
        // Fetch Location Index
        guard let index = locations.firstIndex(of: location) else {
            return
        }
        
        // Remove Location
        locations.remove(at: index)
        
        // Save Locations
        self.locations = locations
    }
}
