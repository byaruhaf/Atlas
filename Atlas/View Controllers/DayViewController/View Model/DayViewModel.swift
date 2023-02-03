//
//  DayViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import Foundation

struct DayViewModel {
    let weatherData: CurrentWeatherConditions
    
    var minTemperature: String {
        "\(weatherData.main.tempMin.description) °"
//        String(format: "%.1f °", weatherData.main.tempMin.description)
    }
    
    var maxTemperature: String {
        "\(weatherData.main.tempMax.description) °"
//        String(format: "%.1f °", weatherData.main.tempMax.description)
    }
    
    var temperature: String {
        "\(weatherData.main.feelsLike.description) °"
//        String(format: "%.1f °", weatherData.main.feelsLike.description)
    }
    
    var weatherCondition: String {
        let weatherType = weatherData.weather[0].weatherType
        switch weatherType {
        case .rain, .thunderstorm, .drizzle, .snow:
            return "RAINY"
        case .clouds:
            return "CLOUDY"
        case .clear, .unknown:
            return "SUNNY"
        }
    }
    
    var backgroundImageName: String {
        let weatherType = weatherData.weather[0].weatherType
        switch weatherType {
        case .rain, .thunderstorm, .drizzle, .snow:
            return ThemeManager.shared.currentImageTheme!.rain
        case .clouds:
            return ThemeManager.shared.currentImageTheme!.cloudy
        case .clear, .unknown:
            return ThemeManager.shared.currentImageTheme!.sunny
        }
    }
}
