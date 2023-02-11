//
//  Double+Extension.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 11/02/2023.
//

import Foundation

extension Double {
    var toFahrenheit: Double {
        let celsius = Measurement(value: self, unit: UnitTemperature.celsius)
        let fahrenheit = celsius.converted(to: .fahrenheit).value
        return fahrenheit
    }
}
