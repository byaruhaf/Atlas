//
//  CurrentWeather.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation
// To be removed after
// swiftlint:disable all

struct CurrentWeather: Codable {
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
    
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
        let pressure: Int
        let humidity: Int
        let seaLevel: Int
        let grndLevel: Int
        
        private enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double
    }
    
    struct Cloud: Codable {
        let all: Int
    }
    
    struct Sy: Codable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Date
        let sunset: Date
    }
    
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Cloud
    let dt: Date
    let sys: Sy
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}
