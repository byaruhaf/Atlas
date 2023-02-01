//
//  Forecast.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation

struct List: Codable {
    let date: Date
    let main: Main
    let weather: [Weather]
    
    private enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
    }
}

struct Forecast: Codable {
    let list: [List]
}
