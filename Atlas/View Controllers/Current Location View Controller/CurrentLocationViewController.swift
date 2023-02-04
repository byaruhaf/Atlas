//
//  CurrentLocationViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 31/01/2023.
//

import UIKit

final class CurrentLocationViewController: UIViewController {
    
    // MARK: - Constants
    
    private let segueDayView = "SegueDayView"
    private let segueForcastView = "SegueForcastView"
    
    // MARK: - IBOutlet
    @IBOutlet private var dayViewController: DayViewController!
    @IBOutlet private var forcastViewController: ForecastViewController!
    
    // MARK: - Properties
    var viewModel: CurrentLocationViewModel? {
        didSet {
            guard let viewModel else { return }
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case segueDayView:
            guard let destination = segue.destination as? DayViewController else {
                fatalError("Unexpected Destination View Controller")
            }
            
            // Update Day View Controller
            self.dayViewController = destination
        case segueForcastView:
            guard let destination = segue.destination as? ForecastViewController else {
                fatalError("Unexpected Destination View Controller")
            }
            
            // Update Forcast View Controller
            self.forcastViewController = destination
        default:
            break
        }
    }
    
    // MARK: - Helper Methods
    
    private func setupViewModel(with viewModel: CurrentLocationViewModel) {
        Task(priority: .userInitiated) {
            do {
                try await viewModel()
                updateChildViewControllerViewModels(with: viewModel)
            } catch {
                Alert.presentDefaultError(for: self)
                print(error.localizedDescription) // TODO: Log this with Logger
            }
        }
    }
    
    private func updateChildViewControllerViewModels(with: CurrentLocationViewModel) {
        // Configure Day View Controller
        guard let current = viewModel?.current else { return }
        self.dayViewController.viewModel = DayViewModel(weatherData: current)
        determineColorTheme(condtion: current.weather[0].weatherType)
        // Configure Forcast View Controller
        guard let forecast = viewModel?.forecast else { return }
        self.forcastViewController.viewModel = ForecastViewModel(weatherData: forecast)
    }
    
    private func determineColorTheme(condtion: WeatherType) {
        switch condtion {
        case .rain, .thunderstorm, .drizzle, .snow:
            ThemeManager.shared.currentBackgroundColor = RainColorTheme()
        case .clouds:
            ThemeManager.shared.currentBackgroundColor = CloudyColorTheme()
        case .clear, .unknown:
            ThemeManager.shared.currentBackgroundColor = SunnyColorTheme()
        }
    }
}
