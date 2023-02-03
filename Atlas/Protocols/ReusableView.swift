//
//  ReusableView.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 03/02/2023.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
