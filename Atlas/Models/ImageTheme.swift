//
//  Theme.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import UIKit.UIImage

protocol ImageTheme {
    var cloudy: UIImage { get }
    var sunny: UIImage { get }
    var rain: UIImage { get }
}

struct ForestImageTheme: ImageTheme {
    let cloudy = UIImage(named: "forest_cloudy") ?? UIImage(systemName: "exclamationmark.triangle.fill")!
    let sunny = UIImage(named: "forest_sunny") ?? UIImage(systemName: "exclamationmark.triangle.fill")!
    let rain = UIImage(named: "forest_rainy") ?? UIImage(systemName: "exclamationmark.triangle.fill")!
}

struct SeaImageTheme: ImageTheme {
    let cloudy = UIImage(named: "sea_cloudy") ?? UIImage(systemName: "exclamationmark.triangle.fill")!
    let sunny = UIImage(named: "sea_sunny") ?? UIImage(systemName: "exclamationmark.triangle.fill")!
    let rain = UIImage(named: "sea_rainy") ?? UIImage(systemName: "exclamationmark.triangle.fill")!
}
