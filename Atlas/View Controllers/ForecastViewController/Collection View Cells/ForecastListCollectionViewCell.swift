//
//  ForecastListCollectionViewCell.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 03/02/2023.
//

import UIKit

class ForecastListCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    
    @IBOutlet var dayOfWeekLable: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var temperatureLable: UILabel!
    @IBOutlet var backgroundVDayiew: UIView! {
        didSet {
            backgroundVDayiew.tintColor = UIColor.Atlas.baseTextColor
            backgroundVDayiew.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet var smallTitleLabels: [UILabel]! {
        didSet {
            for label in smallTitleLabels {
                label.textColor = UIColor.Atlas.baseTextColor
                label.font = UIFont.Atlas.bodyRegular
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with forecastDayViewModel: any WeekDayRepresentable) {
        self.dayOfWeekLable.text = forecastDayViewModel.day
        self.temperatureLable.text = forecastDayViewModel.temperature.description
        self.iconImageView.image = forecastDayViewModel.backgroundImageName
        backgroundView?.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
        backgroundVDayiew.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
    }
}
