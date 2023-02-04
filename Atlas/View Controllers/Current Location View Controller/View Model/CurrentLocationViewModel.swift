//
//  CurrentLocationViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation
import CoreLocation

enum WeatherDataError: Error {
    case notAuthorizedToRequestLocation
    case failedToRequestLocation
    case noWeatherDataAvailable
}

// @MainActor
final class CurrentLocationViewModel: WeatherData {
    var current: CurrentWeatherConditions?
    var forecast: ForecastWeatherConditions?
        
    func callAsFunction() async throws {
        do {
            async let current = try await self.loadCurrentWeatherData(for: Defaults.location)
            async let forecast = try await self.loadForecastWeatherData(for: Defaults.location)
            self.current = try await current
            self.forecast = try await forecast
        } catch {
            print(error.localizedDescription) // TODO: Log this with Logger
            throw  WeatherDataError.noWeatherDataAvailable
        }
    }

    func loadCurrentWeatherData(for location: CLLocation) async throws -> CurrentWeather {
        let weatherRequest = WeatherRequest(requestType: .weather, units: .metric, location: location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func loadForecastWeatherData(for location: CLLocation) async throws -> Forecast {
        let weatherRequest = WeatherRequest(requestType: .forecast, units: .metric, location: location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func fetch<T: Decodable>(from urlRequest: URLRequest) async throws -> T {
        let (appNetData, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("The response statusCode is \(String(describing: (response as? HTTPURLResponse)?.statusCode))") // TODO: Log this with Logger
            throw  WeatherDataError.noWeatherDataAvailable
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let result = try decoder.decode(T.self, from: appNetData)
            return result
        } catch {
            throw  WeatherDataError.noWeatherDataAvailable
        }
    }
}
