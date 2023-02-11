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
        let temperature = weatherData.main.tempMin
        
        switch UserDefaults.temperatureNotation {
        case .celsius:
            return String(format: "%.2f °C", temperature)
        case .fahrenheit:
            return String(format: "%.2f °F", temperature.toFahrenheit)
        }
    }
    
    var maxTemperature: String {
        let temperature = weatherData.main.tempMax
        
        switch UserDefaults.temperatureNotation {
        case .celsius:
            return String(format: "%.2f °C", temperature)
        case .fahrenheit:
            return String(format: "%.2f °F", temperature.toFahrenheit)
        }
    }
    
    var temperature: String {
        let temperature = weatherData.main.feelsLike
        
        switch UserDefaults.temperatureNotation {
        case .celsius:
            return String(format: "%.2f °C", temperature)
        case .fahrenheit:
            return String(format: "%.2f °F", temperature.toFahrenheit)
        }
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
