//
//  WeatherRequest.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation
import CoreLocation

enum RequestType: String {
    case weather, forecast
}

enum TemperatureUnit: String {
    case metric, forecast
}

enum Defaults {
    static let location = CLLocation(latitude: 0.347596, longitude: 32.582520)
}

struct WeatherRequest {
    
    // MARK: - Properties
    let requestType: RequestType
    let units: TemperatureUnit
    let location: CLLocation
    
    // MARK: -
    
    private var latitude: Double {
        location.coordinate.latitude
    }
    
    private var longitude: Double {
        location.coordinate.longitude
    }
    
    // MARK: -
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/\(requestType.rawValue)"
        urlComponents.queryItems = [
            .init(name: "lat", value: "\(latitude)"),
            .init(name: "lon", value: "\(longitude)"),
            .init(name: "appid", value: "\(WeatherService.apiKey)"),
            .init(name: "units", value: "\(units.rawValue)")
        ]
        
        guard let url = urlComponents.url else {
            // if we can’t create a URL, Exit immediately and complain loudly.
            fatalError("Unable to Create URL for Weather Service Request")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
