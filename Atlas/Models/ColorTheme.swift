//
//  ColorTheme.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import UIKit.UIColor

protocol ColorTheme {
    var backgroundColor: UIColor { get }
}

struct CloudyColorTheme: ColorTheme {
    let backgroundColor = UIColor(named: "CLOUDY") ?? UIColor.white
}

struct SunnyColorTheme: ColorTheme {
    let backgroundColor = UIColor(named: "SUNNY") ?? UIColor.white
}
struct RainColorTheme: ColorTheme {
    let backgroundColor = UIColor(named: "RAINY") ?? UIColor.white
}
