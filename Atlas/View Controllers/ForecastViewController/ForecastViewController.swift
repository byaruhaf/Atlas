//
//  ForecastViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

final class ForecastViewController: UIViewController {
    
    // MARK: -
    
    var viewModel: ForecastViewModel? {
        didSet {
            // updateView()
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
    
    private func setupViewModel(with viewModel: ForecastViewModel) {
        print(viewModel.weatherData.list[0].weather)
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
        // Register for Observer
        registerForTheme()
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    private func setupView() {
        // Configure View
        view.backgroundColor = UIColor(named: "SUNNY")
    }
    
    deinit {
        // Register for Observer
        registerForTheme()
    }
}

// swiftlint:disable notification_center_detachment
// swiftlint:disable explicit_init
extension ForecastViewController: ThemeableColor {
    func registerForTheme() {
        print("gggggggggggggggggggggggggggggg")
        NotificationCenter.default.addObserver(
            self, selector: #selector(colorChanged), name: NSNotification.Name.init("ColorChanged"),
            object: nil)
    }
   
    func unregisterForTheme() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func colorChanged() {
        animateColor()
    }
    
    func animateColor() {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
        }
    }
}
