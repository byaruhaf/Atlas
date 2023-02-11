//
//  ForecastDayViewModelTests.swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 04/02/2023.
//

import XCTest
@testable import Atlas

// swiftlint:disable force_try
final class ForecastDayViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: ForecastDayViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Load Stub
        let data = loadStub(name: "forecast", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Openweathermap Response
        let forecastResponse = try! decoder.decode(Forecast.self, from: data)
        
        // Get  weatherData
        let forecastviewModel = ForecastViewModel(weatherData: forecastResponse)
        
        // Get  weatherData
        let weatherData = forecastviewModel.weatherData
        
        // Initialize View Model
        viewModel = forecastviewModel.generateForecastDayViewModel(from: weatherData).first!
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    // MARK: - Tests for condition
    func testWeeksDayWeatherData_condition() throws {
        XCTAssertEqual(viewModel.condition, "Clouds")
    }
    
    // MARK: - Tests for temperature
    func testWeeksDayWeatherData_temperature() throws {
        XCTAssertEqual(viewModel.temperature.description, "3.28 °C")
    }
    
    // MARK: - Tests for backgroundImageName
    func testWeeksDayWeatherData_backgroundImageName() throws {
        let viewModelImage = viewModel.backgroundImageName
        let imageDataViewModel = viewModelImage.pngData()!
        let pointSize = UIImage.SymbolConfiguration(pointSize: 30)
        let caption = UIImage.SymbolConfiguration(textStyle: .caption2)
        let thin = UIImage.SymbolConfiguration(weight: .thin)
        let combined = caption.applying(pointSize).applying(thin)
        let imageDataReference = UIImage(systemName: "cloud", withConfiguration: combined)!.pngData()!
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
}
