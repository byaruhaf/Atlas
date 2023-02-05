//
//  LocationServicing.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 05/02/2023.
//

import Foundation

protocol LocationServicing {
    // MARK: - Properties
    var isNotAuthorized: Bool { get }
    
    // MARK: - Methods
    func fetchUserLocation() async throws -> Location
    func fetchUserAuthorizatio() async throws
}
