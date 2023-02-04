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
        let pointSize = UIImage.SymbolConfiguration(pointSize: 30)
        let caption = UIImage.SymbolConfiguration(textStyle: .caption2)
        let thin = UIImage.SymbolConfiguration(weight: .thin)
        let combined = caption.applying(pointSize).applying(thin)
        
        switch condition {
        case .clear:
            return UIImage(systemName: "sun.max", withConfiguration: combined)!
        case .clouds:
            return UIImage(systemName: "cloud", withConfiguration: combined)!
        case .drizzle:
            return UIImage(systemName: "cloud.drizzle", withConfiguration: combined)!
        case .rain:
            return UIImage(systemName: "cloud.rain", withConfiguration: combined)!
        case .snow:
            return UIImage(systemName: "cloud.snow", withConfiguration: combined)!
        case .thunderstorm:
            return UIImage(systemName: "cloud.bolt.rain", withConfiguration: combined)!
        case .unknown:
            return UIImage(systemName: "cloud.sun.rain", withConfiguration: combined)!
        }
    }
}
