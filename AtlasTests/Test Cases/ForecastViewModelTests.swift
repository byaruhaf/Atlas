//
//  ForecastViewModelTests.swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 04/02/2023.
//

import XCTest
@testable import Atlas

// swiftlint:disable force_try
final class ForecastViewModelTests: XCTestCase {

    // MARK: - Properties
    
    var viewModel: ForecastViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Load Stub
        let data = loadStub(name: "forecast", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Dark Sky Response
        let forecastResponse = try! decoder.decode(Forecast.self, from: data)
        
        // Initialize View Model
        viewModel = ForecastViewModel(weatherData: forecastResponse)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    // MARK: - Tests for day
    func testWeeksDayWeatherData_day() throws {
        let firstDay = viewModel.weeksDayWeatherData.first!
        XCTAssertEqual(firstDay.day, "  Sat 12:00 PM")
    }
    
    // MARK: - Tests for condition
    func testWeeksDayWeatherData_condition() throws {
        let firstDay = viewModel.weeksDayWeatherData.first!
        XCTAssertEqual(firstDay.condition, "Clouds")
    }
    
    // MARK: - Tests for temperature
    func testWeeksDayWeatherData_temperature() throws {
        let firstDay = viewModel.weeksDayWeatherData.first!
        XCTAssertEqual(firstDay.temperature.description, "3.28")
    }

    // MARK: - Tests for backgroundImageName
    func testWeeksDayWeatherData_backgroundImageName() throws {
        let firstDay = viewModel.weeksDayWeatherData.first!
        let viewModelImage = firstDay.backgroundImageName
        let imageDataViewModel = viewModelImage.pngData()!
        let pointSize = UIImage.SymbolConfiguration(pointSize: 30)
        let caption = UIImage.SymbolConfiguration(textStyle: .caption2)
        let thin = UIImage.SymbolConfiguration(weight: .thin)
        let combined = caption.applying(pointSize).applying(thin)
        let imageDataReference = UIImage(systemName: "cloud", withConfiguration: combined)!.pngData()!
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
}
