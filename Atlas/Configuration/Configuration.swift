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
