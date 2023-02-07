//
//  FavoriteCitiesViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 07/02/2023.
//

import Foundation

class FavoriteCitiesViewModel: Equatable, Hashable {
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

extension FavoriteCitiesViewModel {
    static func == (lhs: FavoriteCitiesViewModel, rhs: FavoriteCitiesViewModel) -> Bool {
        lhs.city == rhs.city
    }
    
    func hash(into hasher: inout Hasher) {
        city.hash(into: &hasher)
    }
}
