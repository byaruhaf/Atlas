//
//  Alert.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 01/02/2023.
//

import Foundation
import UIKit

// swiftlint:disable convenience_type
class Alert {
    class func showBasic(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
    class func presentDefaultError(for viewController: UIViewController) {
        Alert.showBasic(title: "Unable to Fetch Weather Data", message: "The application is unable to fetch weather data. Please make sure your device is connected over Wi-Fi or cellular.", viewController: viewController)
    }
}
