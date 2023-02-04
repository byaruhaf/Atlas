//
//  AtlasError.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 04/02/2023.
//

import Foundation

enum AtlasError: Error, CustomStringConvertible {
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
