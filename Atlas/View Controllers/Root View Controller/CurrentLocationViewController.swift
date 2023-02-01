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
            await fetchWeatherDate()
        }
    }
    
    private func setupView() {
        // Configure View
        view.backgroundColor = UIColor(named: "SUNNY")
    }
    
    private func fetchWeatherDate() async {
        
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

        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
        
        guard let url2 = urlComponents2.url else { return }
        var request2 = URLRequest(url: url2)
        request2.httpMethod = "GET"
        
        
        do {
            let (currentWeatherData, response) = try await URLSession.shared.data(for: request)
            let (forecastWeatherData, response2) = try await URLSession.shared.data(for: request2)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let result = try decoder.decode(CurrentWeather.self, from: currentWeatherData)
            print(result)
            
            guard (response2 as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let result2 = try decoder.decode(Forecast.self, from: forecastWeatherData)
            print(result2)
        } catch {
            print(error.localizedDescription)
        }
    }
}
