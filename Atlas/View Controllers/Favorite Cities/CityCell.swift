//
//  CityCell.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 07/02/2023.
//

import UIKit

class CityCell: UICollectionViewCell, SelfConfiguringCityCell {
    @IBOutlet var currentTemperatureLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var localityLabel: UILabel!
    
    private let networkService = NetworkSservice()
    
    func configure(with location: Location) {
        self.nameLabel.text = location.name
        self.localityLabel.text = location.locality
        Task {
            let temp = try await loadCurrentWeatherData(for: location).main.feelsLike.description
            self.currentTemperatureLabel.text = "\(temp) °"
        }
    }
    
    func loadCurrentWeatherData(for location: Location) async throws -> CurrentWeather {
        let weatherData = try await networkService.loadCurrentWeatherData(for: location)
        return weatherData
    }
    
    override func layoutSubviews() {
        // cell rounded section
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
