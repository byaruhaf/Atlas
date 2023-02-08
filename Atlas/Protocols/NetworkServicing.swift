//
//  NetworkServicing.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 05/02/2023.
//

import Foundation

protocol NetworkServicing {
    
    // MARK: - Methods
    func loadCurrentWeatherData(for location: Location) async throws -> CurrentWeather
    func loadForecastWeatherData(for location: Location) async throws -> Forecast
}
