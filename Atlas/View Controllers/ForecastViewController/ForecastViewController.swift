//
//  ForecastViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

final class ForecastViewController: UIViewController {
    @IBOutlet var flable: UILabel!
    
    // MARK: -
    
    var viewModel: ForecastViewModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Public Interface
    
    //    override func reloadData() {
    //        updateView()
    //    }
    
    // MARK: - View Methods
    
    private func updateView() {
        flable.text = viewModel?.weatherData.list[0].main.tempMax.description
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
    
    private func updateWeatherDataContainerView(with viewModel: ForecastViewModel) {
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
    }
}
