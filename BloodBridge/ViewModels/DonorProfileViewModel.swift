//
//  DonorProfileViewModel.swift
//  BloodBridge
//
//  ViewModel for fetching, creating, and updating donor profile in Firestore.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class DonorProfileViewModel: ObservableObject {
    // Form input fields
    @Published var fullName: String = ""
    @Published var selectedBloodGroup: String = "O+"
    @Published var phone: String = ""
    @Published var city: String = ""
    @Published var area: String = ""
    @Published var isAvailable: Bool = true
    
    // UI state feedback
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var successMessage: String = ""
    
    // Firestore reference
    private let db = Firestore.firestore()
    
    // MARK: - Fetch Profile from Firestore
    func fetchProfile() {
        // Ensure user is authenticated
        guard let uid = Auth.auth().currentUser?.uid else {
            errorMessage = "Please log in to view your profile."
            return
        }
        
        isLoading = true
        errorMessage = ""
        successMessage = ""
        
        // Read document from "donors" collection using current user's UID
        db.collection("donors").document(uid).getDocument { [weak self] document, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                if let document = document, document.exists, let data = document.data() {
                    // Existing profile found: populate fields
                    self?.fullName = data["fullName"] as? String ?? ""
                    self?.selectedBloodGroup = data["bloodGroup"] as? String ?? "O+"
                    self?.phone = data["phone"] as? String ?? ""
                    self?.city = data["city"] as? String ?? ""
                    self?.area = data["area"] as? String ?? ""
                    self?.isAvailable = data["isAvailable"] as? Bool ?? true
                } else {
                    // Profile does not exist yet: prefill full name from Auth
                    if let currentUser = Auth.auth().currentUser {
                        self?.fullName = currentUser.displayName ?? ""
                    }
                }
            }
        }
    }
    
    // MARK: - Save or Update Profile in Firestore
    func saveProfile() {
        guard let uid = Auth.auth().currentUser?.uid else {
            errorMessage = "Please log in to save your profile."
            return
        }
        
        errorMessage = ""
        successMessage = ""
        
        let trimmedName = fullName.trimmingCharacters(in: .whitespaces)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespaces)
        let trimmedCity = city.trimmingCharacters(in: .whitespaces)
        let trimmedArea = area.trimmingCharacters(in: .whitespaces)
        
        // Basic input validation
        if trimmedName.isEmpty || trimmedPhone.isEmpty || trimmedCity.isEmpty || trimmedArea.isEmpty {
            errorMessage = "Please fill in all profile fields."
            return
        }
        
        isLoading = true
        
        // Prepare dictionary for Firestore (no passwords, includes userId)
        let profileData: [String: Any] = [
            "userId": uid,
            "fullName": trimmedName,
            "bloodGroup": selectedBloodGroup,
            "phone": trimmedPhone,
            "city": trimmedCity,
            "area": trimmedArea,
            "isAvailable": isAvailable
        ]
        
        // Create or update document using current user's UID
        db.collection("donors").document(uid).setData(profileData, merge: true) { [weak self] error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.successMessage = "Profile updated successfully!"
                }
            }
        }
    }
}

