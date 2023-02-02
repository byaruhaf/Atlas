//
//  WeatherData.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation

protocol WeatherData {
//
//    var latitude: Double { get }
//    var longitude: Double { get }
    
    var current: CurrentWeatherConditions? { get set }
    var forecast: ForecastWeatherConditions? { get set }
}

protocol CurrentWeatherConditions {
    var weather: [Weather] { get }
    var main: Main { get }
    var weatherType: WeatherType { get }
}

protocol ForecastWeatherConditions {
    var list: [List] { get }
}
