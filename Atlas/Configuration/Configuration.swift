//
//  Configuration.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation

enum WeatherService {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
}

enum Configuration {
    
    static var refreshThreshold: TimeInterval {
#if DEBUG
        return 60.0
#else
        return 10.0 * 60.0
#endif
    }
}
