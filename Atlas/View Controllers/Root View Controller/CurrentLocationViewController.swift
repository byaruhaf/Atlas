//
//  CurrentLocationViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 31/01/2023.
//

import UIKit

final class CurrentLocationViewController: UIViewController {

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
    
    // MARK: - Helper Methods
    
    private func setupViewModel(with viewModel: CurrentLocationViewModel) {
        Task(priority: .userInitiated) {
            
            do {
                try await viewModel()
                print(viewModel.forecast.debugDescription)
                print(viewModel.current.debugDescription)
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
