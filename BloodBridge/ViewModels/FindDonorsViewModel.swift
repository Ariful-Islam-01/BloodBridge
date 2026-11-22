//
//  FindDonorsViewModel.swift
//  BloodBridge
//
//  ViewModel for fetching, searching, and filtering donors from Cloud Firestore.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class FindDonorsViewModel: ObservableObject {
    // List of all donors fetched from Firestore
    @Published var donors: [DonorProfile] = []
    
    // User search inputs
    @Published var searchText: String = ""
    @Published var selectedBloodGroup: String = "All"
    
    // UI state
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    // Firestore reference
    private let db = Firestore.firestore()
    
    // MARK: - Fetch Donors from Firestore
    func fetchDonors() {
        isLoading = true
        errorMessage = ""
        
        // Fetch all documents from the "donors" collection
        db.collection("donors").getDocuments { [weak self] snapshot, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                // Get the current logged-in user's UID to exclude them from results
                let currentUID = Auth.auth().currentUser?.uid ?? ""
                var fetchedList: [DonorProfile] = []
                
                if let documents = snapshot?.documents {
                    for document in documents {
                        let data = document.data()
                        let docUserId = data["userId"] as? String ?? document.documentID
                        
                        // Do not show the current user in search results
                        if docUserId == currentUID {
                            continue
                        }
                        
                        let donor = DonorProfile(
                            userId: docUserId,
                            fullName: data["fullName"] as? String ?? "Anonymous Donor",
                            bloodGroup: data["bloodGroup"] as? String ?? "Unknown",
                            phone: data["phone"] as? String ?? "",
                            city: data["city"] as? String ?? "",
                            area: data["area"] as? String ?? "",
                            isAvailable: data["isAvailable"] as? Bool ?? true
                        )
                        fetchedList.append(donor)
                    }
                }
                
                self?.donors = fetchedList
            }
        }
    }
    
    // MARK: - Filtered Donors (Blood Group & Search Query)
    var filteredDonors: [DonorProfile] {
        donors.filter { donor in
            // 1. Filter by Blood Group ("All" matches any)
            let matchesBloodGroup = (selectedBloodGroup == "All") || (donor.bloodGroup == selectedBloodGroup)
            
            // 2. Filter by Search Query (Name, City, or Area)
            let query = searchText.trimmingCharacters(in: .whitespaces)
            let matchesQuery: Bool
            if query.isEmpty {
                matchesQuery = true
            } else {
                matchesQuery = donor.fullName.localizedCaseInsensitiveContains(query) ||
                               donor.city.localizedCaseInsensitiveContains(query) ||
                               donor.area.localizedCaseInsensitiveContains(query)
            }
            
            return matchesBloodGroup && matchesQuery
        }
    }
}

