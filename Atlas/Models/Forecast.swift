//
//  Forecast.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation

struct Forecast: Codable {
    struct List: Codable {
        struct Main: Codable {
            let temp: Double
            let feelsLike: Double
            let tempMin: Double
            let tempMax: Double
            let pressure: Int
            let seaLevel: Int
            let grndLevel: Int
            let humidity: Int
            let tempKf: Double
            
            private enum CodingKeys: String, CodingKey {
                case temp
                case feelsLike = "feels_like"
                case tempMin = "temp_min"
                case tempMax = "temp_max"
                case pressure
                case seaLevel = "sea_level"
                case grndLevel = "grnd_level"
                case humidity
                case tempKf = "temp_kf"
            }
        }
        
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        struct Cloud: Codable {
            let all: Int
        }
        
        struct Wind: Codable {
            let speed: Double
            let deg: Int
            let gust: Double
        }
        
        struct Sy: Codable {
            let pod: String
        }
        
        struct Rain: Codable {
            let _3h: Double
            
            private enum CodingKeys: String, CodingKey {
                case _3h = "3h"
            }
        }
        
        let dt: Date
        let main: Main
        let weather: [Weather]
        let clouds: Cloud
        let wind: Wind
        let visibility: Int
        let pop: Double
        let sys: Sy
        let dtTxt: String
        let rain: Rain?
        
        private enum CodingKeys: String, CodingKey {
            case dt
            case main
            case weather
            case clouds
            case wind
            case visibility
            case pop
            case sys
            case dtTxt = "dt_txt"
            case rain
        }
    }
    
    struct City: Codable {
        struct Coord: Codable {
            let lat: Double
            let lon: Double
        }
        
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population: Int
        let timezone: Int
        let sunrise: Date
        let sunset: Date
    }
    
    let cod: String
    let message: Int
    let cnt: Int
    let list: [List]
    let city: City
}
