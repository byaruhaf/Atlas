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
            backgroundVDayiew.tintColor = .white
            backgroundVDayiew.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet var smallTitleLabels: [UILabel]! {
        didSet {
            for label in smallTitleLabels {
                label.textColor = .white
                label.font = UIFont.Atlas.bodyRegular
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with weatherDayData: WeatherDayData) {
        self.dayOfWeekLable.text = weatherDayData.day
        self.temperatureLable.text = weatherDayData.temperature.description
        self.iconImageView.image = weatherDayData.backgroundImageName
        backgroundView?.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
        backgroundVDayiew.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
    }
}
