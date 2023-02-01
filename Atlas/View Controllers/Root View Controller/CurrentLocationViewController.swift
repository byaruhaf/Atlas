//
//  CurrentLocationViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 31/01/2023.
//

import UIKit

final class CurrentLocationViewController: UIViewController {
    
    var viewModel: CurrentLocationViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View Model
        setupViewModel(with: viewModel)
        
        // Setup View
        setupView()
        Task(priority: .userInitiated) {
            do {
                async let currentWeatherData = loadCurrentWeatherData()
                async let forecastWeatherData = loadForecastWeatherData()
                
                await print(try currentWeatherData)
                await print(try forecastWeatherData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func setupViewModel(with viewModel: CurrentLocationViewModel?) {
        guard let viewModel = viewModel else {
            return
        }
        // Configure Title Label
        print(viewModel.title)
    }
    
    private func setupView() {
        // Configure View
//        view.backgroundColor = UIColor(named: "SUNNY")
    }
    
    func loadCurrentWeatherData() async throws -> CurrentWeather {
        let weatherRequest = WeatherRequest(requestType: .weather, units: .metric, location: Defaults.location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func loadForecastWeatherData() async throws -> Forecast {
        let weatherRequest = WeatherRequest(requestType: .forecast, units: .metric, location: Defaults.location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func fetch<T: Decodable>(from urlRequest: URLRequest) async throws -> T {
        let (appNetData, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: appNetData)
        return result
    }
}

enum CustomError: Error, CustomStringConvertible {
    case message(String)
    
    var description: String {
        switch self {
        case let .message(message):
            return message
        }
    }
    
    init(_ message: String) {
        self = .message(message)
    }
}
