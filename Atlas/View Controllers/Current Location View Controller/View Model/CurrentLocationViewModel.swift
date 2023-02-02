//
//  CurrentLocationViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation

enum WeatherDataError: Error {
    case notAuthorizedToRequestLocation
    case failedToRequestLocation
    case noWeatherDataAvailable
}

// @MainActor
final class CurrentLocationViewModel: WeatherData {
    private var currentWeatherTaskHandle: Task<CurrentWeather, Error>?
    private var forecastTaskHandle: Task<Forecast, Error>?
    var current: CurrentWeatherConditions?
    var forecast: ForecastWeatherConditions?
        
    func callAsFunction() async throws {
        do {
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
        } catch {
            print(error.localizedDescription) // TODO: Log this with Logger
            throw  WeatherDataError.noWeatherDataAvailable
        }
    }
    
    deinit {
        currentWeatherTaskHandle?.cancel()
        forecastTaskHandle?.cancel()
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
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("The response statusCode is \(String(describing: (response as? HTTPURLResponse)?.statusCode))") // TODO: Log this with Logger
            throw  WeatherDataError.noWeatherDataAvailable
        }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: appNetData)
            return result
        } catch {
            throw  WeatherDataError.noWeatherDataAvailable
        }
    }
}
