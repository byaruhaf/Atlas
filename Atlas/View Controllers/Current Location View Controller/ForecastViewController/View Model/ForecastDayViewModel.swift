//
//  ForecastDayViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 04/02/2023.
//

import UIKit.UIImage

struct ForecastDayViewModel {
    var day: String
    var condition: String
    var temperature: String
    
    var backgroundImageName: UIImage {
        guard let weatherType = WeatherType(rawValue: condition) else { return UIImage(systemName: "cloud")! }
        return WeatherConditionIcon.image(for: weatherType)
    }
}

extension ForecastDayViewModel: WeekDayRepresentable {
}
