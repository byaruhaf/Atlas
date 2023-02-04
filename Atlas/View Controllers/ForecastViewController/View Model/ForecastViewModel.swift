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
        dateFormatter.dateFormat = "EE"
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        weatherData.list.forEach { ddd in
            temp.append(
                WeatherDayData(day: "  \(dateFormatter.string(from: ddd.date)) \(timeFormatter.string(from: ddd.date))",
                               condition: "\(ddd.weather.first!.main)",
                               temperature: ddd.main.feelsLike)
            )
        }
        return temp
    }
}
