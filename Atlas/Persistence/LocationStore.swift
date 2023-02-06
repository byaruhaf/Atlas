//
//  LocationStore.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 07/02/2023.
//

import Foundation

// swiftlint:disable force_try
class LocationStore {
    @Published
    private(set) var cities: [Location]
    
    init(cities: [Location]) {
        self.cities = cities
    }
    
    static let userDefaultsKey = "cities"
    
    static func load() -> LocationStore {
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return LocationStore(cities: [])
        }
        do {
            let cities = try decoder.decode([Location].self, from: data)
            return LocationStore(cities: cities)
        } catch {
            print("Error decoding cities: \(error)")
            return LocationStore(cities: [])
        }
    }
    
    func add(_ city: Location) {
        cities.append(city)
        try! save()
    }
    
    func remove(_ city: Location) {
        guard let index = cities.firstIndex(of: city) else { return }
        cities.remove(at: index)
        try! save()
    }
    
    func save() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(cities)
        UserDefaults.standard.set(data, forKey: Self.userDefaultsKey)
    }
}
