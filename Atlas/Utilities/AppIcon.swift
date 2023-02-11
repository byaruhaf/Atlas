//
//  AppIcon.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 11/02/2023.
//

import UIKit

enum AppIcon: String, CaseIterable, Identifiable {
    case primary = "AppIcon"
    case secondary = "AppIconT"
    
    var id: String { rawValue }
    var iconName: String? {
        switch self {
        case .primary:
            /// `nil` is used to reset the app icon back to its primary icon.
            return nil
        default:
            return rawValue
        }
    }
    
    var description: String {
        switch self {
        case .primary:
            return "Cloud Icon"
        case .secondary:
            return "Temperature Icon"
        }
    }
    
    var preview: UIImage {
        UIImage(named: rawValue + "-Preview") ?? UIImage()
    }
}
