//
//  MockNetworkService.swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 06/02/2023.
//

import Foundation
@testable import Atlas

class MockNetworkService: NetworkServicing {
    var currentWeatherData: CurrentWeather!
    var forecastWeatherData: Forecast!
    
    // MARK: - Network Service
    func loadCurrentWeatherData(for location: Atlas.Location) async throws -> Atlas.CurrentWeather {
        currentWeatherData
    }
    
    func loadForecastWeatherData(for location: Atlas.Location) async throws -> Atlas.Forecast {
        forecastWeatherData
    }
}
