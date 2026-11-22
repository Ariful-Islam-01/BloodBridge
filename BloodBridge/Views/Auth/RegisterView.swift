//
//  RegisterView.swift
//  BloodBridge
//
//  Registration screen using simple SwiftUI components with loading state.
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
                    .disabled(authViewModel.isLoading)
                    
                    CustomTextField(
                        title: "Email Address",
                        icon: "envelope.fill",
                        text: $authViewModel.registerEmail
                    )
                    .disabled(authViewModel.isLoading)
                    
                    CustomSecureField(
                        title: "Password (min 6 characters)",
                        icon: "lock.fill",
                        text: $authViewModel.registerPassword
                    )
                    .disabled(authViewModel.isLoading)
                    
                    CustomSecureField(
                        title: "Confirm Password",
                        icon: "lock.shield.fill",
                        text: $authViewModel.registerConfirmPassword
                    )
                    .disabled(authViewModel.isLoading)
                    
                    // Error message display
                    if !authViewModel.errorMessage.isEmpty {
                        Text(authViewModel.errorMessage)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    
                    // Register Button with Loading Spinner
                    PrimaryButton(
                        title: "Register",
                        icon: "person.badge.plus",
                        isLoading: authViewModel.isLoading
                    ) {
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
                    .disabled(authViewModel.isLoading)
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
