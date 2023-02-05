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
//         Setup Notification Handling
//        setupNotificationHandling()
        // Register for Observer
        registerForegroundNotification()
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
                if viewModel.isNotAuthorized && (UserDefaults.getDidDataRefresh == nil) {
                    _ = try await viewModel.fetchUserAuthorizatio()
                }
                
                let location = try await viewModel.fetchUserLocation()
                
                // Configure Day View Controller
                async let current = try await viewModel.loadCurrentWeatherData(for: location)
                // Initialize Day View Model
                let dayViewModel = await DayViewModel(weatherData: try current)
                // Update Day View Controller
                self.dayViewController.viewModel = dayViewModel
                
                // Configure Forcast View Controller
                async let forecast = try await viewModel.loadForecastWeatherData(for: location)
                // Initialize Forcast View Model
                let forcastViewModel = await ForecastViewModel(weatherData: try forecast)
                // Update Forcast View Controller
                self.forcastViewController.viewModel = forcastViewModel
                
                // Update User Defaults Refresh Time
                UserDefaults.setDidDataRefresh(Date())
            } catch {
                Alert.presentDefaultError(for: self)
                print(error.localizedDescription) // TODO: Log this with Logger
            }
        }
    }
    
    private func refresh() {
        guard let viewModel else { return }
        setupViewModel(with: viewModel)
    }
    deinit {
        // Register for Observer
        unregisterForegroundNotification()
    }
}

// swiftlint:disable notification_center_detachment
extension CurrentLocationViewController {
    func registerForegroundNotification() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(enteringForeground), name: UIApplication.willEnterForegroundNotification,
            object: nil)
    }
    
    func unregisterForegroundNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func enteringForeground() {
        guard let lastDataRefresh = UserDefaults.getDidDataRefresh else {
            return
        }
        
        if Date().timeIntervalSince(lastDataRefresh) > Configuration.refreshThreshold {
            self.refresh()
        }
    }
}
