//
//  RegisterView.swift
//  BloodBridge
//
//  Registration screen using simple SwiftUI components.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                BloodBridgeLogoView()
                    .padding(.top, 20)
                
                Text("Create New Account")
                    .font(.title2)
                    .fontWeight(.bold)
                
                // Form Card
                VStack(spacing: 16) {
                    CustomTextField(
                        title: "Full Name",
                        icon: "person.fill",
                        text: $authViewModel.registerFullName
                    )
                    
                    CustomTextField(
                        title: "Email Address",
                        icon: "envelope.fill",
                        text: $authViewModel.registerEmail
                    )
                    
                    CustomSecureField(
                        title: "Password",
                        icon: "lock.fill",
                        text: $authViewModel.registerPassword
                    )
                    
                    CustomSecureField(
                        title: "Confirm Password",
                        icon: "lock.shield.fill",
                        text: $authViewModel.registerConfirmPassword
                    )
                    
                    // Error message display
                    if !authViewModel.errorMessage.isEmpty {
                        Text(authViewModel.errorMessage)
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                    
                    // Register Button (UI only for Phase 2)
                    PrimaryButton(title: "Register", icon: "person.badge.plus") {
                        authViewModel.register()
                    }
                }
                .padding()
                .background(AppTheme.cardBackground)
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Back to Login Button
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    
                    Button("Log In") {
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.primaryRed)
                }
                .padding(.top, 10)
            }
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RegisterView()
            .environmentObject(AuthViewModel())
    }
}
