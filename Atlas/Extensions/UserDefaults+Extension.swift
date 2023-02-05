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
    }
    
    class func setDidDataRefresh(_ didSeedPersistentStore: Date) {
        UserDefaults.standard.set(didSeedPersistentStore, forKey: Keys.didDataRefresh)
    }
    
    class var getDidDataRefresh: Date? {
         UserDefaults.standard.object(forKey: Keys.didDataRefresh) as? Date
    }
}
