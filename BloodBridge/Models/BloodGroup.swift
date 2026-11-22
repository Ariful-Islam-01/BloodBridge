//
//  BloodGroup.swift
//  BloodBridge
//
//  Blood group definitions and compatibility data models.
//

import Foundation

enum BloodGroup: String, CaseIterable, Identifiable, Codable {
    case aPositive = "A+"
    case aNegative = "A-"
    case bPositive = "B+"
    case bNegative = "B-"
    case abPositive = "AB+"
    case abNegative = "AB-"
    case oPositive = "O+"
    case oNegative = "O-"
    
    var id: String { rawValue }
    
    var isUniversalDonor: Bool {
        self == .oNegative
    }
    
    var isUniversalRecipient: Bool {
        self == .abPositive
    }
}

// Data model representing educational blood group compatibility information
struct BloodGroupInfo: Identifiable, Codable {
    var id: String { bloodGroup }
    let bloodGroup: String
    let canDonateTo: [String]
    let canReceiveFrom: [String]
    let description: String
}
