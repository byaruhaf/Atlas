//
//  Log.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 07/02/2023.
//

import Foundation
import os.log

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs the view cycles like viewDidLoad.
    static let location = Logger(subsystem: subsystem, category: "Location")
    static let storage = Logger(subsystem: subsystem, category: "Storage")
    static let network = Logger(subsystem: subsystem, category: "Networking")
}

// Logger.network.error("❌ did NOT get categories: \(error)")
// Logger.network.debug("✅ Got single category: \(String(describing: category))")
