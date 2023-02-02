//
//  Themeable.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 02/02/2023.
//

import Foundation

protocol Themeable {
    func registerForTheme()
    func unregisterForTheme()
}

protocol ThemeableColor: Themeable {
    func colorChanged()
}

protocol ThemeableImage: Themeable {
    func imageChanged()
}
