//
//  MockLocationService.swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 06/02/2023.
//

import Foundation
@testable import Atlas

class MockLocationService: LocationServicing {
    // MARK: - Properties
    var isNotAuthorized = true
    var location: Location? = Location(name: "Test Name", locality: "Test Name", latitude: 44.34, longitude: 10.99)
    
    // MARK: - Location Service
    func fetchUserLocation() async throws -> Atlas.Location {
        if let location = location {
            return location
        } else {
            throw Atlas.WeatherDataError.failedToRequestLocation
        }
    }
    
    func fetchUserAuthorizatio() async throws {
    }
}
