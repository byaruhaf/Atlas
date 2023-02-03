//
//  Theme.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import UIKit.UIImage

protocol ImageTheme {
    var cloudy: String { get }
    var sunny: String { get }
    var rain: String { get }
}

struct ForestImageTheme: ImageTheme {
    let cloudy = "forest_cloudy"
    let sunny = "forest_sunny"
    let rain = "forest_rainy"
}

struct SeaImageTheme: ImageTheme {
    let cloudy = "sea_cloudy"
    let sunny = "sea_sunny"
    let rain = "sea_rainy"
}
