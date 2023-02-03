//
//  WeatherConditionIcon.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

// move to utilities and call feom here
enum WeatherConditionIcon {
    static func image(for condition: WeatherType) -> UIImage {
        switch condition {
        case .clear:
            return UIImage(systemName: "sun.max.fill")!
        case .clouds:
            return UIImage(systemName: "cloud.fill")!
        case .drizzle:
            return UIImage(systemName: "cloud.drizzle.fill")!
        case .rain:
            return UIImage(named: "rain")!
        case .snow:
            return UIImage(systemName: "cloud.snow.fill")!
        case .thunderstorm:
            return UIImage(systemName: "cloud.bolt.rain.fill")!
        case .unknown:
            return UIImage(systemName: "cloud")!
        }
    }
}
