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
    
    // MARK: - Properties
    
    @IBOutlet private var dayViewController: DayViewController!
    @IBOutlet private var forcastViewController: ForecastViewController!
    
    var viewModel: CurrentLocationViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
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
                print(viewModel.forecast.debugDescription)
                print(viewModel.current.debugDescription)
                // Configure Day View Controller
                guard let current = viewModel.current else { return }
                self.dayViewController.viewModel = DayViewModel(weatherData: current)
                
                // Configure Forcast View Controller
                guard let forecast = viewModel.forecast else { return }
                self.forcastViewController.viewModel = ForecastViewModel(weatherData: forecast)
            } catch {
                Alert.showBasic(title: "Unable to Fetch Weather Data", message: "The application is unable to fetch weather data. Please make sure your device is connected over Wi-Fi or cellular.", viewController: self)
                print(error.localizedDescription) // TODO: Log this with Logger
            }
        }
    }
}

enum CustomError: Error, CustomStringConvertible {
    case message(String)
    
    var description: String {
        switch self {
        case let .message(message):
            return message
        }
    }
    
    init(_ message: String) {
        self = .message(message)
    }
}
