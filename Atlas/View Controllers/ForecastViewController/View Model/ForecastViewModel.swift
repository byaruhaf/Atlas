//
//  ForecastViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import Foundation

struct ForecastViewModel {
    let weatherData: ForecastWeatherConditions
    
    var weeksDayWeatherData: [WeatherDayData] {
        var temp: [WeatherDayData] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        weatherData.list.forEach { ddd in
            temp.append(WeatherDayData(day: "\(dateFormatter.string(from: ddd.date))", condition: "\(ddd.weather.first!.main)", temperature: ddd.main.feelsLike))
        }
        return temp
    }
}

struct WeatherDayData: Hashable {
    var day: String
    var condition: String
    var temperature: Double
}
