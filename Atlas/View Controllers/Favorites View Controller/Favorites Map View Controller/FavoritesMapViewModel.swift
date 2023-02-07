//
//  FavoritesMapViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 07/02/2023.
//

import MapKit

class FavoritesMapViewModel {
    var locations: [Location] = UserDefaults.locations
    
    var userPins: [MapPin] {
        var temp: [MapPin] = []
        for location in locations {
            temp.append(MapPin(title: location.name, locationName: location.locality, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
        }
        return temp
    }
}
