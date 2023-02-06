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
    
    // MARK: - Location Service
    func fetchUserLocation() async throws -> Atlas.Location {
        Location(latitude: 44.34, longitude: 10.99)
    }
    
    func fetchUserAuthorizatio() async throws {
    }
}
