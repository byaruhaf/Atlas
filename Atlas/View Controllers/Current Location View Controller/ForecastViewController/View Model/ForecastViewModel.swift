//
//  ForecastViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import Foundation

struct ForecastViewModel {
    let weatherData: ForecastWeatherConditions
    
    func generateForecastDayViewModel(from weatherData: ForecastWeatherConditions) -> [ForecastDayViewModel] {
        var temp: [ForecastDayViewModel] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        weatherData.list.forEach { ddd in
            temp.append(
                ForecastDayViewModel(day: "  \(dateFormatter.string(from: ddd.date)) \(timeFormatter.string(from: ddd.date))",
                                     condition: "\(ddd.weather.first!.main)",
                                     temperature: ddd.main.feelsLike)
            )
        }
        return temp
    }
}
