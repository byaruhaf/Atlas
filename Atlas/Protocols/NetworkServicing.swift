//
//  NetworkServicing.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 05/02/2023.
//

import Foundation
import os.log

protocol NetworkServicing {
    
    // MARK: - Methods
    func loadCurrentWeatherData(for location: Location) async throws -> CurrentWeather
    func loadForecastWeatherData(for location: Location) async throws -> Forecast
}

class NetworkSservice: NetworkServicing {
    
    func loadCurrentWeatherData(for location: Location) async throws -> CurrentWeather {
        let weatherRequest = WeatherRequest(requestType: .weather, units: .metric, location: location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func loadForecastWeatherData(for location: Location) async throws -> Forecast {
        let weatherRequest = WeatherRequest(requestType: .forecast, units: .metric, location: location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func fetch<T: Decodable>(from urlRequest: URLRequest) async throws -> T {
        let (appNetData, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            Logger.network.error("The response statusCode is \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
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
