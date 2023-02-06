//
//  CityViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 07/02/2023.
//

import Foundation

class CityViewModel: Equatable, Hashable {
    private let city: Location
    private let networkService: NetworkServicing

    
    init(city: Location, networkService: NetworkServicing) {
        // Set City Location
        self.city = city
        // Set Network Service
        self.networkService = networkService
    }
    
    var cityName: String {
        city.name
    }
    
    var cityLocality: String {
        city.locality
    }
    
    func loadCurrentWeatherData(for location: Location) async throws -> CurrentWeather {
        try await networkService.loadCurrentWeatherData(for: location)
    }
}

extension CityViewModel {
    static func ==(lhs: CityViewModel, rhs: CityViewModel) -> Bool {
        return lhs.city == rhs.city
    }
    
    func hash(into hasher: inout Hasher) {
        city.hash(into: &hasher)
    }
}
