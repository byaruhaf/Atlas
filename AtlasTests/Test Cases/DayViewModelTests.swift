//
//  DayViewModelTests.swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 04/02/2023.
//

import XCTest
@testable import Atlas

// swiftlint:disable force_try
final class DayViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: DayViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Load Stub
        let data = loadStub(name: "current", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Initialize Openweathermap Response
        let currentWeatherResponse = try! decoder.decode(CurrentWeather.self, from: data)
        
        // Initialize View Model
        viewModel = DayViewModel(weatherData: currentWeatherResponse)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Tests for minTemperature
    func testminTemperature() {
        XCTAssertEqual(viewModel.minTemperature, "0.14 °C")
    }
    
    // MARK: - Tests for maxTemperature
    func testmaxTemperature() {
        XCTAssertEqual(viewModel.maxTemperature, "4.68 °C")
    }
    
    // MARK: - Tests for temperature
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "-1.05 °C")
    }
    
    // MARK: - Tests for weatherCondition
    func testWeatherCondition() {
        XCTAssertEqual(viewModel.weatherCondition, "CLOUDY")
    }
    
    // MARK: - Tests for backgroundImageName
    func testBackgroundImageName() {
        XCTAssertEqual(viewModel.backgroundImageName, "forest_cloudy")
    }
}
