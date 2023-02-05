//
//  CurrentLocationViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation
import CoreLocation

enum WeatherDataError: Error {
    case notAuthorizedToRequestLocation
    case failedToRequestLocation
    case noWeatherDataAvailable
}

final class CurrentLocationViewModel: NSObject {
    var locationContinuation: CheckedContinuation<CLLocationCoordinate2D?, Error>?
    var authorizationContinuation: CheckedContinuation<CLAuthorizationStatus?, Error>?
    private let locationManager: CLLocationManager
    lazy var isNotAuthorized: Bool = {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            return true
        case .restricted:
            return true
        case .denied:
            return true
        case .authorizedAlways, .authorizedWhenInUse:
            return false
        @unknown default:
            return true
        }
    }()
    
    // MARK: - Initialization
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Helper Methods
    func fetchUserLocation() async throws -> CLLocationCoordinate2D? {
        try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            locationManager.requestLocation()
        }
    }
    
    func fetchUserAuthorizatio() async throws -> CLAuthorizationStatus? {
        try await withCheckedThrowingContinuation { continuation in
            self.authorizationContinuation = continuation
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func loadCurrentWeatherData(for location: CLLocationCoordinate2D) async throws -> CurrentWeather {
        let weatherRequest = WeatherRequest(requestType: .weather, units: .metric, location: location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func loadForecastWeatherData(for location: CLLocationCoordinate2D) async throws -> Forecast {
        let weatherRequest = WeatherRequest(requestType: .forecast, units: .metric, location: location)
        return try await fetch(from: weatherRequest.urlRequest)
    }
    
    func fetch<T: Decodable>(from urlRequest: URLRequest) async throws -> T {
        let (appNetData, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("The response statusCode is \(String(describing: (response as? HTTPURLResponse)?.statusCode))") // TODO: Log this with Logger
            throw  WeatherDataError.noWeatherDataAvailable
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let result = try decoder.decode(T.self, from: appNetData)
            return result
        } catch {
            throw  WeatherDataError.noWeatherDataAvailable
        }
    }
}

extension CurrentLocationViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted.")
        case .denied:
            print("You have denied this app location permission. Go to setting to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            authorizationContinuation?.resume(returning: manager.authorizationStatus)
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationContinuation?.resume(returning: locations.first?.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationContinuation?.resume(throwing: error)
    }
}
