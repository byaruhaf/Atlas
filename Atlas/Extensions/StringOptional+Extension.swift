//
//  StringOptional+Extension.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 09/02/2023.
//

import Foundation

extension String? {
    var orEmpty: String {
        self ?? ""
    }
}
