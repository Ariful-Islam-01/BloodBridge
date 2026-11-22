//
//  AuthViewModel.swift
//  BloodBridge
//
//  Simple ViewModel to manage UI login and registration states for Phase 2.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    // Controls whether user is logged in or on the login screen
    @Published var isLoggedIn: Bool = false
    
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
    
    // Simple UI-only login function
    func login() {
        if loginEmail.isEmpty || loginPassword.isEmpty {
            errorMessage = "Please enter both email and password."
        } else {
            isLoggedIn = true
            errorMessage = ""
        }
    }
    
    // Simple UI-only register function
    func register() {
        if registerFullName.isEmpty || registerEmail.isEmpty || registerPassword.isEmpty {
            errorMessage = "Please fill in all fields."
        } else if registerPassword != registerConfirmPassword {
            errorMessage = "Passwords do not match."
        } else {
            isLoggedIn = true
            errorMessage = ""
        }
    }
    
    // Simple UI-only logout function
    func logout() {
        isLoggedIn = false
        loginPassword = ""
        registerPassword = ""
        registerConfirmPassword = ""
        errorMessage = ""
    }
}
