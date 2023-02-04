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
            centerTempLabel.textColor = UIColor.Atlas.baseTextColor
            centerTempLabel.font = UIFont.Atlas.titleHuge
        }
    }
    @IBOutlet var conditonLabel: UILabel! {
        didSet {
            conditonLabel.textColor = UIColor.Atlas.baseTextColor
            conditonLabel.font = UIFont.Atlas.titleLarge
        }
    }
    @IBOutlet var smallValueLabels: [UILabel]! {
        didSet {
            for label in smallValueLabels {
                label.textColor = UIColor.Atlas.baseTextColor
                label.font = UIFont.Atlas.bodyBold
            }
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
    
    // MARK: -
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
            activityIndicatorView.transform = CGAffineTransform(scaleX: 3, y: 3)
        }
    }
    // MARK: -
    
    var viewModel: DayViewModel? {
        didSet {
            guard let viewModel else { return }
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    
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
            self.backgroundImageView.image = UIImage(named: self.viewModel!.backgroundImageName) // TODO: not happy with need to change it.
        }
    }
    
    func animateColor() {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
            self.temperatureRibbon.backgroundColor = ThemeManager.shared.currentBackgroundColor?.backgroundColor
        }
    }
}
