//
//  BloodCompatibilityViewModel.swift
//  BloodBridge
//
//  ViewModel for loading and managing blood group compatibility data from local JSON.
//

import SwiftUI

class BloodCompatibilityViewModel: ObservableObject {
    @Published var bloodGroupsInfo: [BloodGroupInfo] = []
    @Published var selectedGroup: String = "O-"
    @Published var errorMessage: String = ""
    
    init() {
        loadData()
    }
    
    // Loads and decodes the local blood_groups.json file using Bundle.main
    func loadData() {
        errorMessage = ""
        
        // 1. Locate the JSON file inside the app bundle
        guard let fileURL = Bundle.main.url(forResource: "blood_groups", withExtension: "json") else {
            errorMessage = "Could not locate blood_groups.json in app bundle."
            return
        }
        
        // 2. Read and decode the JSON file
        do {
            let data = try Data(contentsOf: fileURL)
            let decoded = try JSONDecoder().decode([BloodGroupInfo].self, from: data)
            self.bloodGroupsInfo = decoded
            if let first = decoded.first {
                self.selectedGroup = first.bloodGroup
            }
        } catch {
            errorMessage = "Failed to load blood group data: \(error.localizedDescription)"
        }
    }
    
    // Helper to get information for the currently selected group
    var selectedInfo: BloodGroupInfo? {
        bloodGroupsInfo.first(where: { $0.bloodGroup == selectedGroup })
    }
}

