//
//  BloodGroup.swift
//  BloodBridge
//
//  Created for Phase 2: UI Foundation & Navigation.
//

import Foundation

enum BloodGroup: String, CaseIterable, Identifiable {
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

