//
//  DonorModel.swift
//  BloodBridge
//
//  Created for Phase 2: UI Foundation & Navigation.
//

import Foundation

struct DonorProfile: Identifiable {
    var id: UUID = UUID()
    var fullName: String
    var bloodGroup: BloodGroup
    var phone: String
    var city: String
    var area: String
    var isAvailable: Bool
    var lastDonationDate: String
}

