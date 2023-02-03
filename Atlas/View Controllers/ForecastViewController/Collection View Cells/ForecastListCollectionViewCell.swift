//
//  ForecastListCollectionViewCell.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 03/02/2023.
//

import UIKit

class ForecastListCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    
    @IBOutlet var backgroundVDayiew: UIView!
    @IBOutlet var dayOfWeekLable: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var temperatureLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with weatherDayData: WeatherDayData) {
        self.dayOfWeekLable.text = weatherDayData.day
        self.temperatureLable.text = weatherDayData.temperature.description
        self.iconImageView.image = UIImage(named: "partlysunny")
        backgroundView?.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
        backgroundVDayiew.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
    }
}
