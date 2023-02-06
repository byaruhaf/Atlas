//
//  CurrentLocationViewModelTests.swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 06/02/2023.
//

import XCTest
@testable import Atlas

// swiftlint:disable force_try
final class CurrentLocationViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: CurrentLocationViewModel!
    var networkService: MockNetworkService!
    var locationService: MockLocationService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Initialize Mock Network Service
        networkService = MockNetworkService()
    
        // Load Stub
        let currentData = loadStub(name: "current", extension: "json")
        let forecastData = loadStub(name: "forecast", extension: "json")
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        // Initialize Openweathermap Response
        let currentWeatherResponse = try! decoder.decode(CurrentWeather.self, from: currentData)
        let forecastResponse = try! decoder.decode(Forecast.self, from: forecastData)
        
        // Configure Mock Network Service
        networkService.currentWeatherData = currentWeatherResponse
        networkService.forecastWeatherData = forecastResponse
        
        // Initialize Mock Location Service
        locationService = MockLocationService()
        
        // Initialize Root View Model
        viewModel = CurrentLocationViewModel(locationService: locationService, networkService: networkService)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Tests for fetchUserLocation
    func testfetchUserLocation() async throws {
        let location = try await viewModel.fetchUserLocation()
        let latitude = 44.34
        let longitude = 10.99
        XCTAssertEqual(location.latitude, latitude)
        XCTAssertEqual(location.longitude, longitude)
    }
    
    // MARK: - Tests for isNotAuthorized
    func testisNotAuthorized() {
        let authorized = viewModel.isNotAuthorized
        XCTAssertTrue(authorized)
    }
    
    // MARK: - Tests for loadCurrentWeatherData
    func testloadCurrentWeatherData() async throws {
        let location = try await viewModel.fetchUserLocation()
        let currentWeatherData = try await viewModel.loadCurrentWeatherData(for: location)
        XCTAssertEqual(currentWeatherData.weather.first?.main, "Clouds")
    }
    
    // MARK: - Tests for loadForecastWeatherData
    func testloadForecastWeatherData() async throws {
        let location = try await viewModel.fetchUserLocation()
        let forecastWeatherData = try await viewModel.loadForecastWeatherData(for: location)
        XCTAssertEqual(forecastWeatherData.list.first?.main.tempMax, 6.39)
    }
}
