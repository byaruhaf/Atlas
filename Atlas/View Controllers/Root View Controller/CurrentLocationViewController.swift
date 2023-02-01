//
//  CurrentLocationViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 31/01/2023.
//

import UIKit
import Combine

final class CurrentLocationViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: CurrentLocationViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
    }
    
    // MARK: - Helper Methods
    
    private func setupViewModel(with viewModel: CurrentLocationViewModel) {
        Task(priority: .userInitiated) {
            
            do {
                try await viewModel()
//                async let currentWeatherData = viewModel.loadCurrentWeatherData()
//                async let forecastWeatherData = viewModel.loadForecastWeatherData()
//
//                await print(try currentWeatherData)
//                await print(try forecastWeatherData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupView() {
        // Configure View
//        view.backgroundColor = UIColor(named: "SUNNY")
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
