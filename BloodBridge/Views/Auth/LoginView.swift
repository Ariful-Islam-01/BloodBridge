//
//  LoginView.swift
//  BloodBridge
//
//  Login screen using simple SwiftUI components with loading state.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // BloodBridge Logo and Title
                BloodBridgeLogoView()
                    .padding(.top, 40)
                
                // Form Card
                VStack(spacing: 16) {
                    CustomTextField(
                        title: "Email Address",
                        icon: "envelope.fill",
                        text: $authViewModel.loginEmail
                    )
                    .disabled(authViewModel.isLoading)
                    
                    CustomSecureField(
                        title: "Password",
                        icon: "lock.fill",
                        text: $authViewModel.loginPassword
                    )
                    .disabled(authViewModel.isLoading)
                    
                    // Error message display
                    if !authViewModel.errorMessage.isEmpty {
                        Text(authViewModel.errorMessage)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    
                    // Login Button with Loading Spinner
                    PrimaryButton(
                        title: "Log In",
                        icon: "arrow.right",
                        isLoading: authViewModel.isLoading
                    ) {
                        authViewModel.login()
                    }
                }
                .padding()
                .background(AppTheme.cardBackground)
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Link to Register Screen
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .fontWeight(.bold)
                            .foregroundColor(AppTheme.primaryRed)
                    }
                    .disabled(authViewModel.isLoading)
                }
                .padding(.top, 10)
            }
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Sign In")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
