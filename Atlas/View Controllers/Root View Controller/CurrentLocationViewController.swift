//
//  CurrentLocationViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 31/01/2023.
//

import UIKit

final class CurrentLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    private func setupView() {
        // Configure View
        view.backgroundColor = UIColor(named: "SUNNY")
    }
    
    func loadCurrentWeatherData() async throws -> CurrentWeather {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            .init(name: "lat", value: "0.347596"),
            .init(name: "lon", value: "32.582520"),
            .init(name: "appid", value: "5a568ba1adb3fc3e8806cb1a4e00b623"),
            .init(name: "units", value: "metric")
            //            .init(name: "units", value: "imperial")
        ]
        
        guard let url = urlComponents.url else {  throw CustomError("Invalid Current Weather URL")  }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return try await fetch(from: request)
    }
    
    func loadForecastWeatherData() async throws -> Forecast {
        var urlComponents2 = URLComponents()
        urlComponents2.scheme = "https"
        urlComponents2.host = "api.openweathermap.org"
        urlComponents2.path = "/data/2.5/forecast"
        urlComponents2.queryItems = [
            .init(name: "lat", value: "0.347596"),
            .init(name: "lon", value: "32.582520"),
            .init(name: "appid", value: "5a568ba1adb3fc3e8806cb1a4e00b623"),
            .init(name: "units", value: "metric")
        ]
        
        guard let url2 = urlComponents2.url else { throw CustomError("Invalid Forecast Weather URL") }
        var request2 = URLRequest(url: url2)
        request2.httpMethod = "GET"
        return try await fetch(from: request2)
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
