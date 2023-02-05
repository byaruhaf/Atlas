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
        viewModel.didFetchLocationData = { [weak self] location, error in
            if let error = error {
                print(error)
            } else if let location = location {
                
                Task(priority: .userInitiated) {
                    do {
                        // Configure Day View Controller
                        async let current = try await viewModel.loadCurrentWeatherData(for: location)
                        self?.dayViewController.viewModel = await DayViewModel(weatherData: try current)
                        // Configure Forcast View Controller
                        async let forecast = try await viewModel.loadForecastWeatherData(for: location)
                        self?.forcastViewController.viewModel = await ForecastViewModel(weatherData: try forecast)
                    } catch {
                        Alert.presentDefaultError(for: self!)
                        print(error.localizedDescription) // TODO: Log this with Logger
                    }
                }
            } else {
                // Notify User
            print("noWeatherDataAvailable")
            }
        }
    }
}
