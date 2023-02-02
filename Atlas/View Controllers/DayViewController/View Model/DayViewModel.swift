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
        weatherData.weather[0].main
    }
    
    var backgroundImageName: String {
        let weatherType = weatherData.weather[0].weatherType
        switch weatherType {
        case .rain, .thunderstorm, .drizzle, .snow:
            return "forest_rainy"
        case .clouds:
            return "forest_cloudy"
        case .clear, .unknown:
            return "forest_sunny"
        }
    }
}
