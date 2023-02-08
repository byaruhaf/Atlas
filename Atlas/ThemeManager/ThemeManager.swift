//
//  ThemeManager.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import Foundation

// swiftlint:disable explicit_init
class ThemeManager {
    static let shared = ThemeManager()
    
    var currentImageTheme: ImageTheme? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.init("ImageChanged"), object: nil)
        }
    }

    var currentBackgroundColor: ColorTheme? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.init("ColorChanged"), object: nil)
        }
    }
    
    private init() {}
    
    func set(imageTheme: ImageTheme) {
        self.currentImageTheme = imageTheme
    }
    
    func set(colorTheme: ColorTheme) {
        self.currentBackgroundColor = colorTheme
    }
}
