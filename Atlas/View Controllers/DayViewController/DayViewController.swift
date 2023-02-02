//
//  DayViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import UIKit

final class DayViewController: UIViewController {
    
    @IBOutlet var temperatureRibbon: UIStackView!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var currentTempLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.contentMode = .scaleToFill
        }
    }
    @IBOutlet var centerTempLabel: UILabel! {
        didSet {
            centerTempLabel.textColor = .white
            centerTempLabel.font = UIFont.Atlas.titleHuge
        }
    }
    @IBOutlet var conditonLabel: UILabel! {
        didSet {
            conditonLabel.textColor = .white
            conditonLabel.font = UIFont.Atlas.titleLarge
        }
    }
    @IBOutlet var smallValueLabels: [UILabel]! {
        didSet {
            for label in smallValueLabels {
                label.textColor = .white
                label.font = UIFont.Atlas.bodyBold
            }
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
    
    // MARK: -
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
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
        // Hide Activity Indicator View
        activityIndicatorView.stopAnimating()
        
        UIView.animate(withDuration: 1) { [self] in
            // Configure Labels
            minTempLabel.text = viewModel.minTemperature
            maxTempLabel.text = viewModel.maxTemperature
            currentTempLabel.text = viewModel.temperature
            centerTempLabel.text = viewModel.temperature
            conditonLabel.text = viewModel.weatherCondition
            backgroundImageView.image = UIImage(named: viewModel.backgroundImageName)
        }
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
        // Register for Observer
        registerForTheme()
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    private func setupView() {
        // Configure View
        animateColor()
        backgroundImageView.image = UIImage(named: "forest_sunny")
    }
    
    deinit {
        // Register for Observer
        registerForTheme()
    }
}

// swiftlint:disable notification_center_detachment
// swiftlint:disable explicit_init
extension DayViewController: ThemeableImage, ThemeableColor {
    func registerForTheme() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(imageChanged), name: NSNotification.Name.init("ImageChanged"),
            object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(colorChanged), name: NSNotification.Name.init("ColorChanged"),
            object: nil)
    }
    
    func unregisterForTheme() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func imageChanged() {
        animateImage()
    }
    
    @objc func colorChanged() {
        animateColor()
    }
    
    func animateImage() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundImageView.image = ThemeManager.shared.currentImageTheme?.cloudy
        }
    }
    
    func animateColor() {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
            self.temperatureRibbon.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
        }
    }
}
