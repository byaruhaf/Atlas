//
//  Styles.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import UIKit

extension UIColor {
    enum Atlas {
        static var baseTextColor: UIColor {
            UIColor.white
        }
        static var cloudyColor: UIColor {
            UIColor(named: "CLOUDY") ?? UIColor.white
        }
        static var sunnyColor: UIColor {
            UIColor(named: "SUNNY") ?? UIColor.white
        }
        static var rainyColor: UIColor {
            UIColor(named: "RAINY") ?? UIColor.white
        }
    }
}

extension UIFont {
    enum Atlas {
        static let bodyRegular: UIFont = .systemFont(ofSize: 17.0, weight: .regular)
        static let bodyBold: UIFont = .systemFont(ofSize: 17.0, weight: .bold)
        static let titleLarge: UIFont = .systemFont(ofSize: 38.0, weight: .regular)
        static let titleHuge: UIFont = .systemFont(ofSize: 62.0, weight: .regular)
    }
}
