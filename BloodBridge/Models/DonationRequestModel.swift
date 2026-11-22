//
//  DonationRequestModel.swift
//  BloodBridge
//
//  Created for Phase 2: UI Foundation & Navigation.
//

import Foundation

struct DonationRequest: Identifiable {
    var id: UUID = UUID()
    var patientName: String
    var bloodGroup: BloodGroup
    var hospital: String
    var city: String
    var area: String
    var unitsNeeded: Int
    var isUrgent: Bool
    var contactPhone: String
    var requiredDate: String
}

