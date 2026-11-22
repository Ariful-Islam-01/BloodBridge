//
//  DonorModel.swift
//  BloodBridge
//
//  Data model representing a donor profile in Firebase Firestore.
//

import Foundation

struct DonorProfile: Identifiable {
    var id: String { userId }
    var userId: String
    var fullName: String
    var bloodGroup: String
    var phone: String
    var city: String
    var area: String
    var isAvailable: Bool
}
