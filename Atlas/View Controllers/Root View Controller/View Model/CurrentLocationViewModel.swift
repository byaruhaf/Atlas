//
//  CurrentLocationViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation

// @MainActor
final class CurrentLocationViewModel {
    private var currentWeatherTaskHandle: Task<CurrentWeather, Error>?
    private var forecastTaskHandle: Task<Forecast, Error>?
    private(set) var current: CurrentWeather?
    private(set) var forecast: Forecast?
    
    func callAsFunction() async throws {
        
        let task1 = Task.detached {
            try await self.loadCurrentWeatherData()
        }
        let task2 = Task.detached {
            try await self.loadForecastWeatherData()
        }
        currentWeatherTaskHandle = task1
        forecastTaskHandle = task2
        
        let currentWeather = try await task1.value
        let forecast = try await task2.value
        self.current = currentWeather
        self.forecast = forecast
    }
    
    func loadCurrentWeatherData() async throws -> CurrentWeather {
        let weatherRequest = WeatherRequest(requestType: .weather, units: .metric, location: Defaults.location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func loadForecastWeatherData() async throws -> Forecast {
        let weatherRequest = WeatherRequest(requestType: .forecast, units: .metric, location: Defaults.location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func fetch<T: Decodable>(from urlRequest: URLRequest) async throws -> T {
        let (appNetData, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: appNetData)
        return result
    }
}
