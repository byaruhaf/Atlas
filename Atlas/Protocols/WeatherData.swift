//
//  WeatherData.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation

protocol CurrentWeatherConditions {
    var weather: [Weather] { get }
    var main: Main { get }
}

protocol ForecastWeatherConditions {
    var list: [List] { get }
}
