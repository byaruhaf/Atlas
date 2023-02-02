//
//  DayViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

final class DayViewController: UIViewController {
 
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var temperatureRibbon: UIStackView!
    @IBOutlet var centerTempLabel: UILabel!
    @IBOutlet var conditonLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var currentTempLabel: UILabel!
    
    // MARK: -
    
    var viewModel: DayViewModel? {
        didSet {
            //            updateView()
            guard let viewModel = viewModel else {
                return
            }
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    
    // MARK: - Public Interface
    
//    override func reloadData() {
//        updateView()
//    }
    
    // MARK: - View Methods
    
    private func setupViewModel(with viewModel: DayViewModel) {
        print(viewModel.weatherData.main.tempMin.description)
        print(viewModel.weatherData.main.tempMax.description)
        print(viewModel.weatherData.main.feelsLike.description)
        print(viewModel.weatherData.main.temp.description)
        print(viewModel.weatherData.weather[0].main)
    }
    
    private func updateView() {
        
//        activityIndicatorView.stopAnimating()
//
//        if let viewModel = viewModel {
//            updateWeatherDataContainerView(with: viewModel)
//
//        } else {
//            messageLabel.isHidden = false
//            messageLabel.text = "Cloudy was unable to fetch weather data."
//        }
    }
    
    // MARK: -
    
    private func updateWeatherDataContainerView(with viewModel: DayViewModel) {
//        weatherDataContainerView.isHidden = false
//
//        dateLabel.text = viewModel.date
//        timeLabel.text = viewModel.time
//        iconImageView.image = viewModel.image
//        windSpeedLabel.text = viewModel.windSpeed
//        descriptionLabel.text = viewModel.summary
//        temperatureLabel.text = viewModel.temperature
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    private func setupView() {
        // Configure View
        view.backgroundColor = UIColor(named: "SUNNY")
        backgroundImageView.image = UIImage(named: "forest_sunny")
    }
}
