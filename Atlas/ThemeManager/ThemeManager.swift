//
//  ThemeManager.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import Foundation

class ThemeManager {
    static let shared = ThemeManager()
    
    // swiftlint:disable explicit_init
    var currentImageTheme: ImageTheme? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.init("ImageChanged"), object: nil)
        }
    }
    // swiftlint:disable explicit_init
    var currentBackgroundColor: ColorTheme? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.init("ColorChanged"), object: nil)
        }
    }
    
    private init() {}
    
    func set(theme: ImageTheme) {
        self.currentImageTheme = theme
    }
    
    func set(backgroundColor: ColorTheme) {
        self.currentBackgroundColor = backgroundColor
    }
}