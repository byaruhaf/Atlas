//
//  FavoritesMapViewModelTests.swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 12/02/2023.
//

import XCTest
@testable import Atlas

final class FavoritesMapViewModelTests: XCTestCase {
    
    var viewModel: FavoritesMapViewModel!
    let location = Location(name: "Test Name", locality: "Test Name", latitude: 44.34, longitude: 10.99)
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Initialize View Model
        UserDefaults.addLocation(location)
        viewModel = FavoritesMapViewModel()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        UserDefaults.removeLocation(location)
    }
    
    // MARK: - Tests for locations
    func testlocations() {
        let location = viewModel.locations
        let latitude = 44.34
        let longitude = 10.99
        XCTAssertEqual(location.first!.latitude, latitude)
        XCTAssertEqual(location.first!.longitude, longitude)
    }
    
    // MARK: - Tests for userPins
    func testuserPins() {
        let userPins = viewModel.userPins
        let name = "Test Name"
        let locality = "Test Name"
        XCTAssertNil(userPins.first)
        XCTAssertEqual(userPins.first!.locationName, locality)
    }
}
