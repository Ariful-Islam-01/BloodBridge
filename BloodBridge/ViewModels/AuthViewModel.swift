//
//  AuthViewModel.swift
//  BloodBridge
//
//  ViewModel managing real Firebase Authentication (Login, Register, Logout).
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    // Tracks if a user is currently authenticated with Firebase
    @Published var isLoggedIn: Bool = false
    
    // Shows loading spinner while authentication requests run
    @Published var isLoading: Bool = false
    
    // Current authenticated user profile data
    @Published var userDisplayName: String = ""
    @Published var userEmail: String = ""
    
    // Login form fields
    @Published var loginEmail: String = ""
    @Published var loginPassword: String = ""
    
    // Register form fields
    @Published var registerFullName: String = ""
    @Published var registerEmail: String = ""
    @Published var registerPassword: String = ""
    @Published var registerConfirmPassword: String = ""
    
    // Error message displayed on the UI
    @Published var errorMessage: String = ""
    
    init() {
        // 1. Check if user is already signed in on app launch
        if let currentUser = Auth.auth().currentUser {
            self.isLoggedIn = true
            self.userDisplayName = currentUser.displayName ?? ""
            self.userEmail = currentUser.email ?? ""
        }
        
        // 2. Listen to real-time Firebase Auth state changes
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                if let user = user {
                    self?.isLoggedIn = true
                    self?.userDisplayName = user.displayName ?? ""
                    self?.userEmail = user.email ?? ""
                } else {
                    self?.isLoggedIn = false
                    self?.userDisplayName = ""
                    self?.userEmail = ""
                }
            }
        }
    }
    
    // MARK: - Firebase Login
    func login() {
        errorMessage = ""
        
        let email = loginEmail.trimmingCharacters(in: .whitespaces)
        let password = loginPassword
        
        // Basic input validation
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please enter both email and password."
            return
        }
        
        isLoading = true
        
        // Call Firebase signIn
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                // Clear password on successful login
                self?.loginPassword = ""
                self?.errorMessage = ""
            }
        }
    }
    
    // MARK: - Firebase Registration
    func register() {
        errorMessage = ""
        
        let name = registerFullName.trimmingCharacters(in: .whitespaces)
        let email = registerEmail.trimmingCharacters(in: .whitespaces)
        let password = registerPassword
        let confirmPassword = registerConfirmPassword
        
        // Basic input validation
        if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Please fill in all fields."
            return
        }
        
        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            return
        }
        
        if password.count < 6 {
            errorMessage = "Password must be at least 6 characters."
            return
        }
        
        isLoading = true
        
        // Call Firebase createUser
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                // Save user's full name in Firebase Authentication profile
                if let user = authResult?.user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = name
                    changeRequest.commitChanges { _ in
                        DispatchQueue.main.async {
                            self?.userDisplayName = name
                        }
                    }
                }
                
                // Clear passwords
                self?.registerPassword = ""
                self?.registerConfirmPassword = ""
                self?.errorMessage = ""
            }
        }
    }
    
    // MARK: - Firebase Logout
    func logout() {
        errorMessage = ""
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            loginPassword = ""
            registerPassword = ""
            registerConfirmPassword = ""
            userDisplayName = ""
            userEmail = ""
        } catch {
            errorMessage = "Failed to log out: \(error.localizedDescription)"
        }
    }
}
