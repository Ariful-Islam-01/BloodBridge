//
//  DonationHistoryModel.swift
//  BloodBridge
//
//  Created for Phase 2: UI Foundation & Navigation.
//

import Foundation

struct DonationRecord: Identifiable {
    var id: UUID = UUID()
    var donationDate: String
    var hospitalOrBloodBank: String
    var city: String
    var unitsDonated: Int
    var notes: String
}

