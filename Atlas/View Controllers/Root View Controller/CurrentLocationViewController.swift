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
                print(error.localizedDescription)
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
