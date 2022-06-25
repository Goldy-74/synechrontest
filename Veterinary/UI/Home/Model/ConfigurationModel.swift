//
//  ConfigurationModel.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import Foundation

// MARK: - Configuration
struct Configuration: Codable {
    let settings: Settings
}

// MARK: - Settings
struct Settings: Codable {
    let isChatEnabled, isCallEnabled: Bool
    let workHours: String
}
