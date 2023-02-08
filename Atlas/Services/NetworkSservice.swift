//
//  NetworkSservice.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 08/02/2023.
//

import Foundation
import os.log

class NetworkSservice: NetworkServicing {
    
    func loadCurrentWeatherData(for location: Location) async throws -> CurrentWeather {
        let weatherRequest = WeatherRequest(requestType: .weather, units: .metric, location: location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func loadForecastWeatherData(for location: Location) async throws -> Forecast {
        let weatherRequest = WeatherRequest(requestType: .forecast, units: .metric, location: location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    /**
     *  Fetch the data from the provided URL request and parse it as the specified Decodable type.
     *
     * - Parameters:
     *   - urlRequest: The URL request to use for fetching the data.
     * - Returns: A Decodable object of the specified type T.
     * - Throws: An error if the response status code is not 200, or if there was an error decoding the data.
     */
    func fetch<T: Decodable>(from urlRequest: URLRequest) async throws -> T {
        // Fetch the data and the response from the URL request
        let (appNetData, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Check if the response status code is 200
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            Logger.network.error("The response statusCode is \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
            throw WeatherDataError.noWeatherDataAvailable
        }
        
        // Create a JSON decoder and set the date decoding strategy to .secondsSince1970
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            // Try to decode the data as the specified type T
            let result = try decoder.decode(T.self, from: appNetData)
            return result
        } catch {
            // Throw an error if there was an error decoding the data
            throw WeatherDataError.noWeatherDataAvailable
        }
    }
}
