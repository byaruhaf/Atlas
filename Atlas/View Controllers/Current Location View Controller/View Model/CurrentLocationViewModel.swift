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

final class CurrentLocationViewModel {
    
    private let locationService: LocationServicing
    private let networkService: NetworkServicing
    
    lazy var isNotAuthorized: Bool = {
        locationService.isNotAuthorized
    }()
    // MARK: - Initialization
    
    init(locationService: LocationServicing, networkService: NetworkServicing) {
        // Set Location Service
        self.locationService = locationService
        // Set Network Service
        self.networkService = networkService
    }
    
    // MARK: - Helper Methods
    func fetchUserLocation() async throws -> Location {
        try await locationService.fetchUserLocation()
    }
    
    func fetchUserAuthorizatio() async throws {
        try await locationService.fetchUserAuthorizatio()
    }
    
    func loadCurrentWeatherData(for location: Location) async throws -> CurrentWeather {
        try await networkService.loadCurrentWeatherData(for: location)
    }
    
    func loadForecastWeatherData(for location: Location) async throws -> Forecast {
        try await networkService.loadForecastWeatherData(for: location)
    }
}
