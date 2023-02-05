//
//  LocationSservice.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 05/02/2023.
//

import Foundation
import CoreLocation

class LocationSservice: NSObject, LocationServicing {
    var locationContinuation: CheckedContinuation<Location, Error>?
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
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Helper Methods
    func fetchUserLocation() async throws -> Location {
        try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            locationManager.requestLocation()
        }
    }
    
    func fetchUserAuthorizatio() async throws {
        _ = try await withCheckedThrowingContinuation { continuation in
            self.authorizationContinuation = continuation
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationSservice: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted.") /// TODO: Log this with Logger
            authorizationContinuation?.resume(throwing: WeatherDataError.notAuthorizedToRequestLocation)
            authorizationContinuation = nil
        case .denied:
            print("You have denied this app location permission. Go to setting to change it") /// TODO: Log this with Logger
            authorizationContinuation?.resume(throwing: WeatherDataError.notAuthorizedToRequestLocation)
            authorizationContinuation = nil
        case .authorizedAlways, .authorizedWhenInUse:
            authorizationContinuation?.resume(returning: manager.authorizationStatus)
            authorizationContinuation = nil
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let selectedLocation = locations.first?.coordinate else { return }
        let location = Location(location: selectedLocation)
        locationContinuation?.resume(returning: location)
        locationContinuation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription) /// TODO: Log this with Logger
        locationContinuation?.resume(throwing: WeatherDataError.failedToRequestLocation)
        locationContinuation = nil
    }
}
