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
    
    // MARK: - Tests weatherData count forecasted
    
    func testNumberOfDays() {
        XCTAssertEqual(viewModel.weatherData.list.count, 40)
    }
    
    // MARK: - Tests for forecast Day ViewModel generation
    
    func testViewModelForIndex() {
        let forecastDayViewModel = viewModel.generateForecastDayViewModel(from: viewModel.weatherData)
        XCTAssertEqual(forecastDayViewModel.first?.temperature.description, "3.28")
    }
}
