//
//  SettingsViewModel.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 11/02/2023.
//

import UIKit

final class SettingsViewModel: ObservableObject {

    @Published private(set) var selectedAppIcon: AppIcon
    
    init() {
        if let iconName = UIApplication.shared.alternateIconName, let appIcon = AppIcon(rawValue: iconName) {
            selectedAppIcon = appIcon
        } else {
            selectedAppIcon = .primary
        }
    }
    func updateAppIcon(to icon: AppIcon) {
        let previousAppIcon = selectedAppIcon
        selectedAppIcon = icon
        
        Task { @MainActor in
            guard UIApplication.shared.alternateIconName != icon.iconName else {
                /// No need to update since we're already using this icon.
                return
            }
            
            do {
                try await UIApplication.shared.setAlternateIconName(icon.iconName)
            } catch {
                /// We're only logging the error here and not actively handling the app icon failure
                /// since it's very unlikely to fail.
                print("Updating icon to \(String(describing: icon.iconName)) failed.")
                
                /// Restore previous app icon
                selectedAppIcon = previousAppIcon
            }
        }
    }
}
