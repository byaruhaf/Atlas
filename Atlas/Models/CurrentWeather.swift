//
//  CurrentWeather.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct CurrentWeather: Codable {
    let weather: [Weather]
    let main: Main
}

 extension Weather {
     var weatherType: WeatherType {
         guard let weatherType = WeatherType(rawValue: self.main) else { return WeatherType.unknown}
         return weatherType
     }
 }

extension CurrentWeather: CurrentWeatherConditions {
}

enum WeatherType: String, Codable {
    case rain = "Rain"
    case clear = "Clear"
    case clouds = "Clouds"
    case snow = "Snow"
    case drizzle = "Drizzle"
    case thunderstorm = "Thunderstorm"
    case unknown
    }
