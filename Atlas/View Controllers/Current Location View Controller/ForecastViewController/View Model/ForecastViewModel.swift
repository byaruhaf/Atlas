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
        weatherData.list.forEach { weatherDataitem in
            temp.append(
                ForecastDayViewModel(day: "  \(dateFormatter.string(from: weatherDataitem.date)) \(timeFormatter.string(from: weatherDataitem.date))",
                                     condition: "\(weatherDataitem.weather.first!.main)",
                                     temperature: temperatureFormatter(weatherDataitem.main.feelsLike))
            )
        }
        return temp
    }
    
    private func temperatureFormatter(_ temperature: Double) -> String {
        switch UserDefaults.temperatureNotation {
        case .celsius:
            return String(format: "%.2f °C", temperature)
        case .fahrenheit:
            return String(format: "%.2f °F", temperature.toFahrenheit)
        }
    }
}
