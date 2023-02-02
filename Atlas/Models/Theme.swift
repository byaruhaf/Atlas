//
//  Theme.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import UIKit.UIColor

protocol Theme {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var borderColor: UIColor { get }
    var widgetBackgroundColor: UIColor { get }
    var downtextColor: UIColor { get }
    var uptextColor: UIColor { get }
    var titletextColor: UIColor { get }
}

protocol Themeable {
    func registerForTheme()
    func unregisterForTheme()
    func themeChanged()
}

struct DarkTheme: Theme {
    let borderColor: UIColor = .yellow
    let backgroundColor: UIColor = .black
    let textColor: UIColor = UIColor(red:0.999, green:0.494, blue:0.000, alpha:1.000)
    let widgetBackgroundColor: UIColor = UIColor(red:0.114, green:0.114, blue:0.114, alpha:1.000)
    let downtextColor: UIColor = .systemRed
    let uptextColor: UIColor = .systemBlue
    let titletextColor: UIColor = UIColor(red:0.999, green:0.494, blue:0.000, alpha:1.000)
}

struct LightTheme: Theme {
    let borderColor: UIColor = UIColor(red:0.145, green:0.127, blue:0.210, alpha:1.000)
    let backgroundColor: UIColor = UIColor(red:0.145, green:0.127, blue:0.210, alpha:1.000)
    let textColor: UIColor = .white
    let widgetBackgroundColor: UIColor = UIColor(red:0.223, green:0.205, blue:0.297, alpha:1.000)
    let downtextColor: UIColor = UIColor(red:0.920, green:0.341, blue:0.403, alpha:1.000)
    let uptextColor: UIColor = .systemBlue
    let titletextColor: UIColor = .white
}
