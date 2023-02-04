//
//  WeatherDayData.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 04/02/2023.
//

import UIKit.UIImage

struct WeatherDayData: Hashable {
    var day: String
    var condition: String
    var temperature: Double
    
    var backgroundImageName: UIImage {
        guard let weatherType = WeatherType(rawValue: condition) else { return UIImage(systemName: "cloud")! }
        return WeatherConditionIcon.image(for: weatherType)
    }
}