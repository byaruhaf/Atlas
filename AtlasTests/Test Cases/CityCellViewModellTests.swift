//
//  CityCellViewModellTests.swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 12/02/2023.
//

import XCTest
@testable import Atlas

// swiftlint:disable force_try
final class CityCellViewModellTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: CityCellViewModel!
    var networkService: MockNetworkService!
    let location = Location(name: "Test Name", locality: "Test Locality", latitude: 44.34, longitude: 10.99)
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Initialize Mock Network Service
        networkService = MockNetworkService()
        
        // Load Stub
        let currentData = loadStub(name: "current", extension: "json")
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        // Initialize Openweathermap Response
        let currentWeatherResponse = try! decoder.decode(CurrentWeather.self, from: currentData)
        
        // Configure Mock Network Service
        networkService.currentWeatherData = currentWeatherResponse
        
        // Initialize Root View Model
        viewModel = CityCellViewModel(city: location, networkService: networkService)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Tests for fetchUserLocation
    func testfetchUserLocation_Success() async throws {
        let name = "Test Name"
        let locality = "Test Locality"
        XCTAssertEqual(viewModel.cityName, name)
        XCTAssertEqual(viewModel.cityLocality, locality)
    }
}
