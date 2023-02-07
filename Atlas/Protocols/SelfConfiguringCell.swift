//
//  SelfConfiguringCell.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 03/02/2023.
//

import Foundation

protocol SelfConfiguringCell {
    func configure(with forecastDayViewModel: any WeekDayRepresentable)
}

protocol SelfConfiguringCityCell {
    func configure(with location: Location)
}
