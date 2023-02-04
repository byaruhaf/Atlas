//
//  SelfConfiguringCell.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 03/02/2023.
//

import Foundation

protocol SelfConfiguringCell {
    func configure(with weatherDayData: any WeekDayRepresentable)
}
