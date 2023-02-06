//
//  CurrentLocationViewModelTests.swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 06/02/2023.
//

import XCTest
@testable import Atlas

final class CurrentLocationViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: CurrentLocationViewModel!
    var networkService: MockNetworkService!
    var locationService: MockLocationService!
    
    
    override func setUpWithError() throws {
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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
