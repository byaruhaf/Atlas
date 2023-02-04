//
//  WeekDayRepresentable.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 04/02/2023.
//

import UIKit.UIImage

protocol WeekDayRepresentable: Hashable {
    var day: String { get }
    var condition: String { get }
    var temperature: Double { get }
    var backgroundImageName: UIImage { get }
}
